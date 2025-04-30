import 'package:flutter/material.dart';

class GeneralSettingsCard extends StatefulWidget {
  const GeneralSettingsCard({super.key});

  @override
  State<GeneralSettingsCard> createState() => _GeneralSettingsCardState();
}

class _GeneralSettingsCardState extends State<GeneralSettingsCard> {
  bool isDarkTheme = false;
  bool notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Загальні налаштування',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Row(
                  children: [
                    Icon(Icons.language, color: Colors.grey),
                    SizedBox(width: 8),
                    Text('Мова', style: TextStyle(color: Colors.black)),
                  ],
                ),
                Text('Українська', style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.dark_mode, color: Colors.grey),
                    SizedBox(width: 8),
                    Text('Темна тема', style: TextStyle(color: Colors.black)),
                  ],
                ),
                Switch(
                  value: isDarkTheme,
                  onChanged: (value) => setState(() => isDarkTheme = value),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.notifications, color: Colors.grey),
                    SizedBox(width: 8),
                    Text('Сповіщення', style: TextStyle(color: Colors.black)),
                  ],
                ),
                Switch(
                  value: notificationsEnabled,
                  onChanged: (value) => setState(() => notificationsEnabled = value),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
