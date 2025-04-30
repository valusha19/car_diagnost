import 'package:flutter/material.dart';
import '../models/vehicle_connection.dart';

class AvailableDevicesSection extends StatelessWidget {
  final List<VehicleConnection> vehicles;
  final String title;
  final String connectButtonText;
  final String notConnectedText;

  const AvailableDevicesSection({
    super.key,
    required this.vehicles,
    this.title = 'Available Devices',
    this.connectButtonText = 'Connect',
    this.notConnectedText = 'Not connected',
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
          ...vehicles.map((vehicle) => _buildAvailableDeviceItem(vehicle)),
        ],
      ),
    );
  }

  Widget _buildAvailableDeviceItem(VehicleConnection vehicle) {
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
                notConnectedText,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(connectButtonText),
          ),
        ],
      ),
    );
  }
}