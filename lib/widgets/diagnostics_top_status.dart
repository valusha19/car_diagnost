import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Верхній блок з температурою, часом у дорозі та оборотами
class DiagnosticsTopStatus extends StatelessWidget {
  const DiagnosticsTopStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
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
        final engineTemp = data['engineTemperature'] ?? 0;
        final travelTime = data['travelTime'] ?? 0;
        final rpm = data['rpm'] ?? 0;

        return Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTextColumn('Температура\nдвигуна', '$engineTemp °C'),
              _buildCenterGauge(rpm), // Передаємо RPM
              _buildTextColumn('Час у дорозі', '${travelTime} хв'),
            ],
          ),
        );
      },
    );
  }

  // Побудова стовпчика з текстом
  Widget _buildTextColumn(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 18, color: Colors.black), textAlign: TextAlign.center),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
      ],
    );
  }

  // Центральний круговий індикатор оборотів
  Widget _buildCenterGauge(int rpm) {
    final double value = (rpm / 7000).clamp(0.0, 1.0); // Нормалізуємо RPM до [0-1]

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(
            value: value,
            backgroundColor: Colors.grey[500],
            color: Colors.teal,
            strokeWidth: 8,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$rpm', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
            const Text('обертів', style: TextStyle(fontSize: 12, color: Colors.black)),
            const Text('хв/км', style: TextStyle(fontSize: 12, color: Colors.black)),
          ],
        ),
      ],
    );
  }
}