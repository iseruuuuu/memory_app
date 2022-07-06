import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.secondarySystemBackground,
        elevation: 0,
        title: const Text(
          '設定',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.black,
          iconSize: 30,
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text(''),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.local_police),
                title: const Text('ライセンス'),
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LicensePage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
