import 'package:flutter/material.dart';

/// Віджет для відображення заголовка секції
/// Використовується для вирівнювання тексту заголовка ліворуч
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8), // Відступи зверху/знизу
      child: Align(
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,                // Збільшений розмір шрифту
            fontWeight: FontWeight.w700, // Насичений жирний
            color: Colors.grey,       // Насичений чорний
          ),
        ),
      ),
    );
  }
}