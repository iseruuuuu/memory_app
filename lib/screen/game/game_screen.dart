import 'package:flutter/material.dart';
import 'package:giff_dialog/giff_dialog.dart';
import '../../parts/game/info_card.dart';
import '../../utils/game_utils.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final Game _game = Game();
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

  @override
  void initState() {
    super.initState();
    _game.initGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                _game.initGame();
                reset();
              });
            },
            child: const Text(
              'リセット',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InfoCard(title: "思考数", info: '$tries'),
              InfoCard(title: "スコア", info: "$score"),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              padding: const EdgeInsets.all(16),
              itemCount: _game.gameImg!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      checkCount();
                      _game.gameImg![index] = _game.cardsList[index];
                      _game.matchCheck.add({index: _game.cardsList[index]});
                    });
                    if (_game.matchCheck.length == 2) {
                      if (_game.matchCheck[0].values.first == _game.matchCheck[1].values.first) {
                        score += 100;
                        _game.matchCheck.clear();
                        checkClear(context);
                      } else {
                        Future.delayed(const Duration(milliseconds: 500), () {
                          setState(() {
                            _game.gameImg![_game.matchCheck[0].keys.first] = _game.hiddenCardPath;
                            _game.gameImg![_game.matchCheck[1].keys.first] = _game.hiddenCardPath;
                            _game.matchCheck.clear();
                          });
                        });
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(_game.gameImg![index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
