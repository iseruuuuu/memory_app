import 'package:flutter/material.dart';
import 'package:memory_app/parts/title/title_button.dart';
import 'package:memory_app/screen/title/title_view_model.dart';
import 'package:provider/provider.dart';

class TitleScreen extends StatelessWidget {
  const TitleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TitleViewModel>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'みんなの神経衰弱',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 100),
            TitleButton(
              onPressed: () => viewModel.goToGame(context),
              text: "一人モード",
            ),
            const SizedBox(height: 100),
            TitleButton(
              onPressed: () => viewModel.goToBattle(context),
              text: "対戦モード",
            ),
            const SizedBox(height: 100),
            TitleButton(
              onPressed: () => viewModel.goToSetting(context),
              text: "設定",
            ),
          ],
        ),
      ),
    );
  }
}
