import 'package:flutter/material.dart';
import 'package:memory_app/screen/game/game_view_model.dart';
import 'package:provider/provider.dart';

import '../../parts/game/info_card.dart';
import '../../utils/game_utils.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final Game _game = Game();

  @override
  void initState() {
    super.initState();
    _game.initGame();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<GameViewModel>();
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
                viewModel.reset();
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
              InfoCard(title: "思考数", info: '${viewModel.tries}'),
              InfoCard(title: "スコア", info: "${viewModel.score}"),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.5,
            child: GridView.builder(
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
                      viewModel.checkCount();
                      _game.gameImg![index] = _game.cardsList[index];
                      _game.matchCheck.add({index: _game.cardsList[index]});
                    });

                    if (_game.matchCheck.length == 2) {
                      if (_game.matchCheck[0].values.first == _game.matchCheck[1].values.first) {
                        viewModel.score += 100;
                        _game.matchCheck.clear();
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
