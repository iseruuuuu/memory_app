import 'package:flutter/material.dart';
import 'package:memory_app/screen/battle/battle_view_model.dart';
import 'package:memory_app/screen/game/game_view_model.dart';
import 'package:memory_app/screen/title/titie_screen.dart';
import 'package:memory_app/screen/title/title_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: TitleViewModel()),
        ChangeNotifierProvider.value(value: GameViewModel()),
        ChangeNotifierProvider.value(value: BattleViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TitleScreen(),
    );
  }
}
