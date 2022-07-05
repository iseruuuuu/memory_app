import 'package:flutter/material.dart';
import 'package:memory_app/screen/game/game_screen.dart';
import '../battle/battle_screen.dart';

class TitleViewModel with ChangeNotifier {
  void goToGame(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GameScreen(),
      ),
    );
  }

  void goToBattle(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BattleScreen(),
      ),
    );
  }

  void goToSetting(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GameScreen(),
      ),
    );
  }
}
