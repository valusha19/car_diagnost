import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../history/service_card.dart';
import '../history/upcoming_service_card.dart';
import 'dart:convert';
class ServiceHistoryPage extends StatelessWidget {
  const ServiceHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "Історія\nобслуговування",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    height: 1.2,
                  ),
                ),
                Text(
                  "Записи технічного обслуговування",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(width: 40), // Для вирівнювання
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildSectionTitle("Останні послуги", textTheme),
            _buildServiceList('past'),
            const SizedBox(height: 20),
            _buildSectionTitle("Найближчі послуги", textTheme),
            _buildServiceList('upcoming'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, TextTheme textTheme) {
    return Text(
      title,
      style: textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildServiceList(String type) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('services')
          .where('type', isEqualTo: type)
          .orderBy('date', descending: type == 'past') // Сортування
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text(
            type == 'past'
                ? "Немає записів про минулі послуги"
                : "Немає запланованих послуг",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black54,
                ),
          );
        }

        final services = snapshot.data!.docs;

        return Column(
          children: services.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
           final service = Service(
  title: data['title'] is String ? data['title'] : json.encode(data['title']),
  date: (data['date'] as Timestamp).toDate(),
  price: data['price'] is String ? data['price'] : json.encode(data['price']),
  nextService: data['nextService'] is String ? data['nextService'] : json.encode(data['nextService']),
  type: data['type'] == 'past'
      ? ServiceType.past
      : ServiceType.upcoming,
            );

            if (type == 'past') {
              return ServiceCard(serviceId: 'service_1');
            } else {
              return UpcomingServiceCard(
                serviceId: 'service_2', // Fixed: Pass the correct instance
                onSchedule: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${service.title} заплановано")),
                  );
                },
              );
            }
          }).toList(),
        );
      },
    );
  }
}

// Клас Service
class Service {
  final String title;
  final DateTime date;
  final String price;
  final String nextService;
  final ServiceType type;

  Service({
    required this.title,
    required this.date,
    required this.price,
    required this.nextService,
    required this.type,
  });
}

enum ServiceType { past, upcoming }