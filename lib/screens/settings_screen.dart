import 'package:flutter/material.dart';
import '../settings/general_settings_card.dart';
import '../settings/car_settings_card.dart';
import '../settings/info_section_card.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: const Text('Налаштування', style: TextStyle(color: Colors.grey)),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            GeneralSettingsCard(),
            SizedBox(height: 16),
            CarSettingsCard(),
            SizedBox(height: 16),
            InfoSectionCard(),
          ],
        ),
      ),
    );
  }
}
