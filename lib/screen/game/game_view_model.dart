import 'package:flutter/material.dart';

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
}
