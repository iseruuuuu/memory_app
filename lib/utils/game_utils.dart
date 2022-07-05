import 'dart:math';

import 'package:flutter/material.dart';

class Game {
  final Color hiddenCard = Colors.red;
  List<Color>? gameColors;
  List<String>? gameImg;
  List<Color> cards = [
    Colors.green,
    Colors.yellow,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.blue
  ];
  final String hiddenCardPath = "assets/images/hidden.png";
  List<String> cardsList = [
    "assets/images/7.png",
    "assets/images/2.png",
    "assets/images/6.png",
    "assets/images/8.png",
    "assets/images/3.png",
    "assets/images/4.png",
    "assets/images/2.png",
    "assets/images/1.png",
    "assets/images/5.png",
    "assets/images/5.png",
    "assets/images/3.png",
    "assets/images/6.png",
    "assets/images/1.png",
    "assets/images/7.png",
    "assets/images/4.png",
    "assets/images/8.png",
  ];
  final int cardCount = 16;
  List<Map<int, String>> matchCheck = [];

  void initGame() {
    gameColors = List.generate(cardCount, (index) => hiddenCard);
    gameImg = List.generate(cardCount, (index) => hiddenCardPath);
    cardsList.shuffle();
  }
}
