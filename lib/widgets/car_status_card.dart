import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import FirebaseFirestore
import 'package:car_diagnost/widgets/status_row.dart';

class CarStatusCard extends StatelessWidget {
  const CarStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Верхній заголовок і іконка
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Стан двигуна',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Продуктивність',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.check, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Блок системної перевірки
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Системна перевірка',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('car_status')
                        .doc('current')
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

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StatusRow(
                            'Напруга акумулятора',
                            '${data['batteryVoltage'] ?? '...'}V',
                            Colors.teal,
                          ),
                          StatusRow(
                            'Трансмісія',
                            data['transmissionStatus'] ?? '...',
                            const Color(0xFFFFA000),
                          ),
                          StatusRow(
                            'Гальмівна система',
                            data['brakeSystemStatus'] ?? '...',
                            Colors.teal,
                          ),
                          StatusRow(
                            'Тиск в шинах',
                            data['tirePressureStatus'] ?? '...',
                            Colors.redAccent,
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Кнопка повної діагностики
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[600],
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Add functionality for full diagnostics
                      },
                      child: const Text(
                        'Запустіть повну діагностику',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}