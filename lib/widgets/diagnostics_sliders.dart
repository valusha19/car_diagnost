import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import FirebaseFirestore

// Повзунки: рівень масла та рівень пального
class DiagnosticsSliders extends StatelessWidget {
  const DiagnosticsSliders({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('car_status')
            .doc('current')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          final double oilLevel = (data['oilLevel'] ?? 50).toDouble();
          final double fuelLevel = (data['fuelLevel'] ?? 50).toDouble();

          return Row(
            children: [
              Expanded(child: _buildSliderTile('Рівень масла', oilLevel)),
              const SizedBox(width: 24),
              Expanded(child: _buildSliderTile('Рівень пального', fuelLevel)),
            ],
          );
        },
      ),
    );
  }

  // Окрема плитка з повзунком і підписом
  Widget _buildSliderTile(String label, double value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Slider(
            value: value,
            onChanged: (_) {}, // Add functionality if needed
            min: 0,
            max: 100,
          ),
          Text(
            '${value.toInt()}%',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}