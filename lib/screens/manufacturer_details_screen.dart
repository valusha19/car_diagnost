import 'package:flutter/material.dart';
import '../manufacturer/info_card.dart';
import '../manufacturer/section_title.dart';

class ManufacturerDetailsScreen extends StatelessWidget {
  const ManufacturerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 254, 254)),
                    ),
                  ),
                  Column(
                    children: const [
                      Text(
                        'Дані\nвиробника',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Технічні характеристики',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: const Text('Інформація про виробника.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            )
                          ],
                        ),
                      );
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.info_outline, color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SectionTitle("Основні параметри"),
                    InfoCard(params: {
                      "Модель двигуна:": "D13K500",
                      "Потужність:": "500 к.с.",
                      "Робочий об'єм:": "12.8 л",
                    }),
                    const SizedBox(height: 16),
                    const SectionTitle("Експлуатаційні межі"),
                    InfoCard(
                      params: {
                        "Макс. оберти:": "2100 об/хв",
                        "Мін. рівень масла:": "2.5 бар",
                        "Макс. температура:": "95°C",
                      },
                      customColors: {
                        "Макс. оберти:": Colors.red,
                        "Мін. рівень масла:": Colors.orange,
                        "Макс. температура:": Colors.red,
                      },
                    ),
                    const SizedBox(height: 16),
                    const SectionTitle("Сервісні інтервали"),
                    InfoCard(
                      params: {
                        "Заміна масла:": "50,000 км",
                        "Паливні фільтри:": "30,000 км",
                        "Повітряний фільтр:": "60,000 км",
                      },
                      valueColor: Colors.teal,
                    ),
                    const SizedBox(height: 16),
                    const SectionTitle("Додаткова інформація"),
                    const InfoCard(
  note: '''
Двигун відповідає нормам Euro 6. Рекомендовано використання палива стандарту EN590.
''',
),
SizedBox(height: 8),
Center(
  child: Text(
    'Серійний номер: XD13K500-2023-UA',
    style: TextStyle(
      fontSize: 14,
      color: Colors.grey,
      fontWeight: FontWeight.w600,
    ),
    textAlign: TextAlign.center,
  ),
),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
