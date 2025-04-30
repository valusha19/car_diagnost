import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import '../monitoring/legend_row.dart';
import '../monitoring/line_chart_widget.dart';
import '../monitoring/message_tile.dart';

class MonitoringScreen extends StatelessWidget {
  const MonitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      body: SafeArea(
        child: Column(
          children: [
            const IconTitleRow(), // Заголовок
            const SizedBox(height: 10),
            const LineChartWidget(), // Графік
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Повідомлення',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Аналіз протягом дня',
                  style: TextStyle(color: Color.fromARGB(255, 99, 98, 98)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('car_messages')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        'Немає повідомлень',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  final messages = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      return MessageTile(
                        title: msg['title'] is String ? msg['title'] : json.encode(msg['title']),
                        subtitle: msg['body'] is String ? msg['body'] : json.encode(msg['body']),
                        date: msg['date'] is String ? msg['date'] : json.encode(msg['date']),
                        color: _getColorFromType(msg['type']),
                        onTap: () {
                          // Додайте функціонал для натискання
                          debugPrint('Повідомлення натиснуто: ${msg['title']}');
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Метод для визначення кольору на основі типу повідомлення
  Color _getColorFromType(String? type) {
    switch (type) {
      case 'critical':
        return Colors.red;
      case 'warning':
        return Colors.orange;
      case 'info':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}