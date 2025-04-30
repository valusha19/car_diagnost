import 'package:flutter/material.dart';
import 'package:car_diagnost/services/ai_service.dart';
import 'package:car_diagnost/widgets/assistant_message_card.dart';
import 'package:car_diagnost/widgets/user_message_bubble.dart';
import 'package:car_diagnost/widgets/message_input_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final AIService _aiService = AIService();
  final List<Map<String, String>> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  

  void _sendMessage(String message) async {
    setState(() {
      _messages.add({'role': 'user', 'content': message});
      _isLoading = true;
    });

    // Scroll to the bottom after adding the message
    _scrollToBottom();

    final aiResponse = await _aiService.getAIResponse(message);

    // Ensure aiResponse is a String
    final String aiResponseString = aiResponse.toString();

    setState(() {
      _messages.add({'role': 'assistant', 'content': aiResponseString});
      _isLoading = false;
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Спілкування з AI'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                if (message['role'] == 'user') {
                  return UserMessageBubble(
                    content: message['content']!,
                    time: 'Тепер',
                  );
                } else {
                  return AssistantMessageCard(
                    messageId: 'message_$index',
                  );
                }
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ),
          MessageInputField(onSend: _sendMessage),
        ],
      ),
    );
  }
}