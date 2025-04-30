import 'package:flutter/material.dart';
import '../models/vehicle_connection.dart';

class ConnectedDevicesSection extends StatelessWidget {
  final List<VehicleConnection> vehicles;
  final String title;
  final bool isUkrainian;

  const ConnectedDevicesSection({
    super.key,
    required this.vehicles,
    this.title = 'Connected Devices',
    this.isUkrainian = false,
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
          const SizedBox(height: 8),
          ...vehicles.map((vehicle) => _buildConnectedDeviceItem(vehicle)),
        ],
      ),
    );
  }

  Widget _buildConnectedDeviceItem(VehicleConnection vehicle) {
    String timeAgo;
    final difference = DateTime.now().difference(vehicle.lastConnected);
    
    if (difference.inMinutes < 60) {
      timeAgo = isUkrainian
          ? '${difference.inMinutes}хв тому'
          : '${difference.inMinutes}m ago';
    } else {
      timeAgo = isUkrainian
          ? '${difference.inHours}год тому'
          : '${difference.inHours}h ago';
    }

    String connectedText = isUkrainian 
        ? 'Підключено • Остання синхр. $timeAgo'
        : 'Connected • Last sync $timeAgo';

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
              Row(
                children: [
                  Text(
                    connectedText,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Icon(Icons.link, color: Colors.green, size: 16),
        ],
      ),
    );
  }
}