import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceCard extends StatelessWidget {
  final String serviceId; // ID документа в Firestore

  const ServiceCard({required this.serviceId, super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('services')
          .doc(serviceId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data?.data() == null) {
          return const Center(
            child: Text(
              'Дані недоступні',
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final String title = data['title'] ?? 'Без назви';
        final DateTime date = (data['date'] as Timestamp).toDate();
        final String price = data['price'] ?? 'Невідомо';
        final String nextService = data['nextService'] ?? 'Невідомо';
        final String type = data['type'] ?? 'past';

        Color borderColor = type == 'past' ? Colors.teal : Colors.orange;

        return Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor, width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${date.day}.${date.month}.${date.year}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Наступне обслуговування: $nextService',
                  style: TextStyle(
                    fontSize: 14,
                    color: borderColor,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    price,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}