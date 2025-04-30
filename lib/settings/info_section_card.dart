import 'package:flutter/material.dart';

class InfoSectionCard extends StatelessWidget {
  const InfoSectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildInfoTile(context, Icons.help_outline, 'Довідка та підтримка'),
        const SizedBox(height: 8),
        _buildInfoTile(context, Icons.info_outline, 'Про додаток'),
      ],
    );
  }

  Widget _buildInfoTile(BuildContext context, IconData icon, String title) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(title, style: const TextStyle(color: Colors.black)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Натиснуто: $title')));
        },
      ),
    );
  }
}
