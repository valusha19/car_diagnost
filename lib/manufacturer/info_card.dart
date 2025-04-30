import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final Map<String, String>? params;
  final Color? valueColor;
  final Color? keyColor;
  final Map<String, Color>? customColors;
  final String? note;

  const InfoCard({
    super.key,
    this.params,
    this.valueColor,
    this.customColors,
    this.keyColor,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    // Якщо нічого не передано — не показуємо нічого
    if (note == null && (params == null || params!.isEmpty)) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: note != null
          ? Text(
              note!,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            )
          : Column(
              children: params!.entries.map((entry) {
                final label = entry.key;
                final value = entry.value;
                final valueTextColor = customColors?[label] ?? valueColor ?? Colors.black;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: 14,
                            color: keyColor ?? Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: valueTextColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }
}
