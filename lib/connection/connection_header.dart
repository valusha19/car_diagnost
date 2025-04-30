import 'package:flutter/material.dart';

class ConnectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onBackPressed;

  const ConnectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onBackPressed,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
        decoration: const BoxDecoration(
          color: Colors.grey, // світло-сірий фон
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
           onPressed: () {
              // Відкриваємо drawer при натисканні
              Navigator.pop(context);
    },
          
        ),
      ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.bluetooth, color: Colors.white),
          onPressed: () {},
        ),
      ),
      ],
    );
  }
}