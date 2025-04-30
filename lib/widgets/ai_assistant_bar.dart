import 'package:flutter/material.dart';
import 'package:car_diagnost/screens/chat_ai_screen.dart';

// Нижня панель із голосовим асистентом (іконка мозку)
class AiAssistantBar extends StatelessWidget {
  const AiAssistantBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: 
        Row(
  children: [
    GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen ()));
      },
      child: const CircleAvatar(
        backgroundColor: Colors.grey,
        child: Icon(Icons.psychology, color: Colors.white),
      ),
    ),
    const SizedBox(width: 12),
    const Text('Привіт! Чим я можу допомогти?'),

  ],
)
    );
  }
}
