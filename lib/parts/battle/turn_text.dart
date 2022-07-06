import 'package:flutter/material.dart';

class TurnText extends StatelessWidget {
  const TurnText({
    Key? key,
    required this.isYourTurn,
  }) : super(key: key);

  final bool isYourTurn;

  @override
  Widget build(BuildContext context) {
    return isYourTurn
        ? Container()
        : const Text(
            'Your Turn',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          );
  }
}