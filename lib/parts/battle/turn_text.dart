import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TurnText extends StatelessWidget {
  const TurnText({
    Key? key,
    required this.isYourTurn,
  }) : super(key: key);

  final bool isYourTurn;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Your Turn',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: isYourTurn
            ? Colors.black
            : CupertinoColors.extraLightBackgroundGray,
      ),
    );
  }
}
