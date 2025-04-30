import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/vehicle_connection.dart';

class HistoryCard extends StatelessWidget {
  final String title;
  final List<VehicleConnection> connectedVehicles;
  final VehicleConnection recentlyConnected;
  final bool isUkrainian;

  const HistoryCard({
    super.key,
    required this.title,
    required this.connectedVehicles,
    required this.recentlyConnected,
    this.isUkrainian = false,
  });

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
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...connectedVehicles.map((vehicle) => _buildHistoryItem(vehicle)),
          _buildHistoryItem(recentlyConnected),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(VehicleConnection vehicle) {
    String timeString;
    if (DateTime.now().difference(vehicle.lastConnected).inDays > 0) {
      timeString = isUkrainian 
          ? 'Останнє підключення вчора'
          : 'Last connected yesterday';
    } else {
      timeString = isUkrainian
          ? 'Підключено сьогодні о ${DateFormat('HH:mm').format(vehicle.lastConnected)}'
          : 'Connected today at ${DateFormat('HH:mm').format(vehicle.lastConnected)}';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vehicle.model,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              Text(
                timeString,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.history, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}