import 'package:flutter/material.dart';

class CarSettingsCard extends StatelessWidget {
  const CarSettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Налаштування автомобіля',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Row(
                  children: [
                    Icon(Icons.straighten, color: Colors.grey),
                    SizedBox(width: 8),
                    Text('Одиниці виміру', style: TextStyle(color: Colors.black)),
                  ],
                ),
                Text('Метричні', style: TextStyle(color: Colors.black)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Row(
                  children: [
                    Icon(Icons.update, color: Colors.grey),
                    SizedBox(width: 8),
                    Text('Інтервал оновлення', style: TextStyle(color: Colors.black)),
                  ],
                ),
                Text('30 сек', style: TextStyle(color: Colors.black)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
