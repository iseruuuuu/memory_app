import 'package:flutter/material.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:memory_app/utils/game_utils.dart';

class BattleViewModel with ChangeNotifier {
  int score1 = 0;
  int score2 = 0;
  bool isCount = false;
  bool isTurn = false;

  void reset() {
    score1 = 0;
    score2 = 0;
  }

  void addScore() {
    if (isTurn) {
      score1 += 100;
    } else {
      score2 += 100;
    }
  }

  void changeTurn() {
    if (isTurn) {
      isTurn = false;
    } else {
      isTurn = true;
    }
  }

  void checkClear(BuildContext context) {
    if (score1 + score2 == 800) {
      showDialog(
        context: context,
        builder: (_) => NetworkGiffDialog(
          image: Image.network(
            "https://media.giphy.com/media/xUOrwiqZxXUiJewDrq/giphy.gif",
            fit: BoxFit.cover,
          ),
          entryAnimation: EntryAnimation.topLeft,
          title: const Text(
            'Finish Game!!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
          ),
          description: const Text(
            'Please try again!!',
            textAlign: TextAlign.center,
            style: TextStyle(
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
            reset();
            Game().initGame();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          onCancelButtonPressed: () {
            reset();
            Game().initGame();
          },
        ),
      );
    }
  }
}
