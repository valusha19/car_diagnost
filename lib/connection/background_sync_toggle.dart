import 'package:flutter/material.dart';

class BackgroundSyncToggle extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  final String title;

  const BackgroundSyncToggle({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.teal,
            activeTrackColor: Colors.teal.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}