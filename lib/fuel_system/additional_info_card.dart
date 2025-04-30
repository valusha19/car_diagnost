import 'package:flutter/material.dart';

class AdditionalInfoCard extends StatelessWidget {
  final String fuelType;
  final double tankCapacity;
  final String fuelQuality;

  const AdditionalInfoCard({
    super.key,
    required this.fuelType,
    required this.tankCapacity,
    required this.fuelQuality,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Додаткова інформація',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow('Тип палива:', fuelType),
          const SizedBox(height: 8),
          _buildInfoRow('Об\'єм баку:', '$tankCapacity л'),
          const SizedBox(height: 8),
          _buildInfoRow('Якість палива:', fuelQuality),
          
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.black54)),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
