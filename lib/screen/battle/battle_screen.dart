import 'package:flutter/material.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:memory_app/parts/battle/turn_text.dart';
import '../../parts/game/info_card.dart';
import '../../utils/game_utils.dart';

class BattleScreen extends StatefulWidget {
  const BattleScreen({Key? key}) : super(key: key);

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  final Game _game = Game();
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

  @override
  void initState() {
    super.initState();
    _game.initGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RotationTransition(
              turns: const AlwaysStoppedAnimation(180 / 360),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TurnText(isYourTurn: isTurn),
                  InfoCard(title: "スコア", info: "${score1}"),
                ],
              ),
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
                        _game.gameImg![index] = _game.cardsList[index];
                        _game.matchCheck.add({index: _game.cardsList[index]});
                      });
                      if (_game.matchCheck.length == 2) {
                        if (_game.matchCheck[0].values.first == _game.matchCheck[1].values.first) {
                          addScore();
                          _game.matchCheck.clear();
                          checkClear(context);
                        } else {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            changeTurn();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TurnText(isYourTurn: !isTurn),
                InfoCard(title: "スコア", info: "$score2"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
