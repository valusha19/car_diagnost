import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/vehicle_connection.dart';
import '../connection/background_sync_toggle.dart';
import '../connection/connection_header.dart';
import '../connection/connected_devices_section.dart';
import '../connection/available_devices_section.dart';
import '../connection/connection_settings.dart';

class VehicleConnectionApp extends StatefulWidget {
  const VehicleConnectionApp({super.key});

  @override
  State<VehicleConnectionApp> createState() => _VehicleConnectionAppState();
}

class _VehicleConnectionAppState extends State<VehicleConnectionApp> {
  bool backgroundSync = true;
  bool autoConnect = true;
  bool connectionNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConnectionHeader(
                title: 'Управління пристроями',
                subtitle: 'Підключення, історія, налаштування',
                onBackPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 16),
              BackgroundSyncToggle(
                value: backgroundSync,
                onChanged: (value) {
                  setState(() {
                    backgroundSync = value;
                  });
                },
                title: 'Фонова синхронізація',
              ),
              const SizedBox(height: 16),
              _buildConnectedDevicesSection(),
              const SizedBox(height: 16),
              _buildAvailableDevicesSection(),
              const SizedBox(height: 16),
              ConnectionSettings(
                autoConnect: autoConnect,
                onAutoConnectChanged: (value) {
                  setState(() {
                    autoConnect = value;
                  });
                },
                connectionNotifications: connectionNotifications,
                onConnectionNotificationsChanged: (value) {
                  setState(() {
                    connectionNotifications = value;
                  });
                },
                backgroundSync: backgroundSync,
                onBackgroundSyncChanged: (value) {
                  setState(() {
                    backgroundSync = value;
                  });
                },
                title: 'Налаштування з’єднання',
                autoConnectText: 'Автопідключення',
                connectionNotificationsText: 'Сповіщення про підключення',
                backgroundSyncText: 'Фонова синхронізація',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConnectedDevicesSection() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('vehicles')
          .where('isConnected', isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text(
            'Немає підключених пристроїв',
            style: TextStyle(color: Colors.black54),
          );
        }

        final connectedVehicles = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return VehicleConnection(
            model: data['model'] ?? 'Невідомо',
            lastConnected: (data['lastConnected'] as Timestamp).toDate(),
            isConnected: data['isConnected'] ?? false,
          );
        }).toList();

        return ConnectedDevicesSection(
          vehicles: connectedVehicles,
          isUkrainian: true,
          title: 'Підключені пристрої',
        );
      },
    );
  }

  Widget _buildAvailableDevicesSection() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('vehicles')
          .where('isConnected', isEqualTo: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text(
            'Немає доступних пристроїв',
            style: TextStyle(color: Colors.black54),
          );
        }

        final availableVehicles = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return VehicleConnection(
            model: data['model'] ?? 'Невідомо',
            lastConnected: (data['lastConnected'] as Timestamp).toDate(),
            isConnected: data['isConnected'] ?? false,
          );
        }).toList();

        return AvailableDevicesSection(
          vehicles: availableVehicles,
          title: 'Доступні пристрої',
          connectButtonText: 'Підключити',
          notConnectedText: 'Не підключено',
        );
      },
    );
  }
}