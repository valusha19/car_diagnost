import 'package:flutter/material.dart';

class IconTitleRow extends StatelessWidget {
  const IconTitleRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _circleIcon(Icons.arrow_back, () {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            } else {
              print('Немає куди повертатись');
            }
          }),
          Column(
            children: const [
              Text(
                'Моніторинг',
                style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w600),
              ),
              Text(
                'Ваша активність.',
                style: TextStyle(color: Color.fromARGB(255, 97, 95, 95), fontSize: 14),
              ),
            ],
          ),
          _circleIcon(Icons.bluetooth, () {
            print('Bluetooth натиснуто');
            // TODO: Відкрити діалог або навігацію на Bluetooth сторінку
          }),
        ],
      ),
    );
  }

  static Widget _circleIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF9DA3AA),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
