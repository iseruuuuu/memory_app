import 'package:flutter/material.dart';
import 'package:memory_app/parts/battle/turn_text.dart';
import 'package:provider/provider.dart';
import '../../parts/game/info_card.dart';
import '../../utils/game_utils.dart';
import 'battle_view_model.dart';

class BattleScreen extends StatefulWidget {
  const BattleScreen({Key? key}) : super(key: key);

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  final Game _game = Game();

  @override
  void initState() {
    super.initState();
    _game.initGame();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<BattleViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            RotationTransition(
              turns: const AlwaysStoppedAnimation(180 / 360),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InfoCard(title: "スコア", info: "${viewModel.score1}"),
                  TurnText(isYourTurn: viewModel.isTurn),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
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
                        // viewModel.checkCount();
                        _game.gameImg![index] = _game.cardsList[index];
                        _game.matchCheck.add({index: _game.cardsList[index]});
                      });
                      if (_game.matchCheck.length == 2) {
                        if (_game.matchCheck[0].values.first == _game.matchCheck[1].values.first) {
                          viewModel.addScore();
                          _game.matchCheck.clear();
                          viewModel.checkClear(context);
                        } else {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            viewModel.changeTurn();
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TurnText(isYourTurn: !viewModel.isTurn),
                InfoCard(title: "スコア", info: "${viewModel.score2}"),
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
