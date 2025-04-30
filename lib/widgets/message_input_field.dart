import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageInputField extends StatefulWidget {
  final Function(String) onSend;

  const MessageInputField({super.key, required this.onSend});

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _handleSend() async {
    final String userMessage = _controller.text.trim();

    if (userMessage.isNotEmpty) {
      // Зберігаємо повідомлення користувача в Firestore
      final userMessageRef = await _firestore.collection('ai_messages').add({
        'role': 'user',
        'content': userMessage,
        'timestamp': FieldValue.serverTimestamp(),
      });
// Використання userMessageRef (наприклад, для логування ID документа)
    debugPrint('User message saved with ID: ${userMessageRef.id}');
      // Очищуємо поле вводу
      _controller.clear();

      // Викликаємо функцію для генерації AI-відповіді
      widget.onSend(userMessage);

      // Генеруємо відповідь AI (імітація або виклик реального сервісу)
      final String aiResponse = await _generateAIResponse(userMessage);

      // Зберігаємо відповідь AI у Firestore
      await _firestore.collection('ai_messages').add({
        'role': 'assistant',
        'content': aiResponse,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<String> _generateAIResponse(String userMessage) async {
    // Тут можна інтегрувати реальний AI-сервіс
    // Наприклад, виклик OpenAI API
    await Future.delayed(const Duration(seconds: 2)); // Імітація затримки
    return "Це відповідь AI на ваше повідомлення: \"$userMessage\"";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Напишіть повідомлення...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.deepPurple),
            onPressed: _handleSend,
          ),
        ],
      ),
    );
  }
}