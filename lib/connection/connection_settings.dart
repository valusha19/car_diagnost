import 'package:flutter/material.dart';

class ConnectionSettings extends StatelessWidget {
  final String title;
  final bool autoConnect;
  final Function(bool) onAutoConnectChanged;
  final String autoConnectText;
  final bool connectionNotifications;
  final Function(bool) onConnectionNotificationsChanged;
  final String connectionNotificationsText;
  final bool backgroundSync;
  final Function(bool) onBackgroundSyncChanged;
  final String backgroundSyncText;

  const ConnectionSettings({
   super.key,
    this.title = 'Connection Settings',
    required this.autoConnect,
    required this.onAutoConnectChanged,
    this.autoConnectText = 'Auto-Connect',
    required this.connectionNotifications,
    required this.onConnectionNotificationsChanged,
    this.connectionNotificationsText = 'Connection Notifications',
    required this.backgroundSync,
    required this.onBackgroundSyncChanged,
    this.backgroundSyncText = 'Background Sync',
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildSettingToggle(autoConnectText, autoConnect, onAutoConnectChanged),
          const SizedBox(height: 8),
          _buildSettingToggle(connectionNotificationsText, connectionNotifications, onConnectionNotificationsChanged),
          const SizedBox(height: 8),
          _buildSettingToggle(backgroundSyncText, backgroundSync, onBackgroundSyncChanged),
        ],
      ),
    );
  }

  Widget _buildSettingToggle(String title, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.teal,
          activeTrackColor: Colors.teal.withOpacity(0.5),
        ),
      ],
    );
  }
}