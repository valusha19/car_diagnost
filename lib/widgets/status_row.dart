import 'package:flutter/material.dart';

// Один рядок статусу (наприклад, "Напруга акумулятора: 12.8V")
class StatusRow extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const StatusRow(this.title, this.value, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 116, 115, 115), // Сірий текст для label
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: color, // Кольорове значення
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
