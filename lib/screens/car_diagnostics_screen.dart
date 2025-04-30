import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import FirebaseFirestore
// Імпорти внутрішніх віджетів
import 'package:car_diagnost/widgets/diagnostics_top_status.dart';
import 'package:car_diagnost/widgets/diagnostics_sliders.dart';
import 'package:car_diagnost/widgets/diagnostics_actions_grid.dart';
import 'package:car_diagnost/widgets/ai_assistant_bar.dart';
import 'package:car_diagnost/screens/vehicle_connection_app_ukrainian.dart';
import 'package:car_diagnost/screens/settings_screen.dart';

// Головний екран діагностики автомобіля
class CarDiagnosticsUIScreen extends StatelessWidget {
  const CarDiagnosticsUIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1F26), // фон AppBar
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1F26),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              // Відкриваємо drawer при натисканні
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: const Text('Діагностика автомобіля', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF1E1F26),
              ),
              child: const Text(
                'Автомобіль',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.directions_car),
              title: const Text('Підключенні транспортні засоби'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VehicleConnectionApp(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat_bubble_outline),
              title: const Text('Спілкування з AI'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/chat');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Налаштування'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback_outlined),
              title: const Text('Зворотній зв\'язок'),
              onTap: () {
                Navigator.pop(context);
                // Відкриття форми зворотного зв'язку
              },
            ),
            ListTile(
              leading: const Icon(Icons.star_outline),
              title: const Text('Оцініть додаток'),
              onTap: () {
                Navigator.pop(context);
                // Відкриття сторінки оцінки
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.grey[200], // фон тіла
        child: Column(
          children: [
            const DiagnosticsTopStatus(), // верхній блок (температура, час, обороти)
            const SizedBox(height: 16),
            const DiagnosticsSliders(),
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('car_status').doc('current').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data?.data() == null) {
                  return const Center(
                    child: Text(
                      'Дані недоступні',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }

                final data = snapshot.data!.data() as Map<String, dynamic>;

                final bool tirePressureLow = data['tirePressureLow'] ?? false;
                final bool oilLevelLow = data['oilLevelLow'] ?? false;
                final bool batteryLow = data['batteryLow'] ?? false;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (tirePressureLow)
                      ElevatedButton(
                        onPressed: () {
                          // Add functionality for tire pressure
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: const Text('🚗 Низький тиск у шинах'),
                      ),
                    if (oilLevelLow)
                      ElevatedButton(
                        onPressed: () {
                          // Add functionality for oil level
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                        child: const Text('🛢️ Низький рівень масла'),
                      ),
                    if (batteryLow)
                      ElevatedButton(
                        onPressed: () {
                          // Add functionality for battery level
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                        child: const Text('🔋 Низький заряд акумулятора'),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            const DiagnosticsActionsGrid(), // сітка з діями
            const Spacer(),
            const AiAssistantBar(), // нижня панель голосового асистента
          ],
        ),
      ),
    );
  }
}