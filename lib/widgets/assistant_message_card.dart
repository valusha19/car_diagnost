import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssistantMessageCard extends StatelessWidget {
  final String messageId; // ID повідомлення в Firestore

  const AssistantMessageCard({
    super.key,
    required this.messageId,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('ai_messages') // Колекція Firestore
          .doc(messageId) // Документ за ID
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
        final String title = data['title'] ?? 'AI';
        final String time = data['time'] ?? 'Невідомо';
        final String content = data['content'] ?? 'Без тексту';

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade400,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.smart_toy, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    time,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                content,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }
}