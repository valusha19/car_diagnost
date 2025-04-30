import 'package:flutter/material.dart';

class CurrentStatusCard extends StatelessWidget {
  final double fuelLevel;
  final double maxFuel;
  final double fuelRange;
  final Function(double) onFuelLevelChanged;

  const CurrentStatusCard({
    super.key,
    required this.fuelLevel,
    required this.maxFuel,
    required this.fuelRange,
    required this.onFuelLevelChanged,
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
            'Поточний стан',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
              'Рівень палива',
               style: TextStyle(color: Colors.black),
               ),
              Text(
                '${fuelLevel.toInt()} літрів',
                style: const TextStyle(color: Colors.teal),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 6,
              activeTrackColor: Colors.teal,
              inactiveTrackColor: Colors.grey[200],
              thumbColor: Colors.teal,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
            ),
            child: Slider(
              value: fuelLevel,
              min: 0,
              max: maxFuel,
              onChanged: onFuelLevelChanged,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Запас ходу:',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                '${fuelRange.toInt()} км',
                style: const TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
