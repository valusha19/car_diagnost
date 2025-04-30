import 'package:flutter/material.dart';

// Верхній AppBar з 3-ма блоками: ← текст → інструменти
class CarStatusAppBar extends StatelessWidget {
  const CarStatusAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 2,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Ліва іконка (стрілка назад)
          _circularIcon(Icons.arrow_back, () => Navigator.of(context).pop()),
          // Текст у центрі
          Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Діагностика\nмашини',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF3B3F4A),
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Стан транспортного засобу',
                style: TextStyle(
                  fontSize: 8,
                  color: Color(0xFF3B3F4A),
                ),
              ),
            ],
          ),
          // Права іконка (інструменти)
          _circularIcon(Icons.build, () {
            debugPrint('Кнопка "Інструменти" натиснута');
          }),
        ],
      ),
    );
  }

  /// Метод для створення круглої іконки з обробником натискання
  static Widget _circularIcon(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF9DA3AA),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}