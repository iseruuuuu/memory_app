import 'package:flutter/material.dart';
import 'package:giff_dialog/giff_dialog.dart';

class GameViewModel with ChangeNotifier {
  bool hideTest = false;
  int tries = 0;
  int score = 0;

  bool isCount = false;

  void reset() {
    tries = 0;
    score = 0;
  }

  void checkCount() {
    if (isCount) {
      isCount = false;
      tries++;
    } else {
      isCount = true;
    }
  }

  void checkClear(BuildContext context) {
    if (score >= 800) {
      showDialog(
        context: context,
        builder: (_) => NetworkGiffDialog(
          image: Image.network(
            "https://media.giphy.com/media/xUOrwiqZxXUiJewDrq/giphy.gif",
            fit: BoxFit.cover,
          ),
          entryAnimation: EntryAnimation.topLeft,
          title: const Text(
            'Congratulations!!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
          ),
          description: Text(
            'Your score is $score.\n'
            ' If you enjoy playing, please try again or play other stage!',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          buttonCancelText: const Text(
            'Try Again',
            style: TextStyle(color: Colors.white),
          ),
          buttonOkText: const Text(
            'Go To Title',
            style: TextStyle(color: Colors.white),
          ),
          onOkButtonPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      );
    }
  }
}
