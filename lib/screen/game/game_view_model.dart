import 'package:flutter/material.dart';
import '../../utils/game_utils.dart';

class GameViewModel with ChangeNotifier {
  bool hideTest = false;

  int tries = 0;
  int score = 0;

  void reset() {
    tries = 0;
    score = 0;
  }
}
