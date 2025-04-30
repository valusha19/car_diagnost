import 'dart:convert'; // Import for JSON decoding
import 'package:dart_openai/dart_openai.dart';

class AIService {
  AIService() {
    OpenAI.apiKey = 'sk-proj-...'; // Replace with your actual API key
  }

 Future<Map<String, dynamic>> getAIResponse(String prompt) async {
  try {
    final response = await OpenAI.instance.chat.create(
      model: "gpt-4",
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          role: OpenAIChatMessageRole.user,
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text(
              "$prompt\n\nВАЖЛИВО: Якщо потрібно змінити налаштування, поверни JSON типу { \"action\": \"enable_dark_theme\" } або аналогічно. Якщо ні, поверни тільки текст."
            )
          ],
        ),
      ],
    );

    final contentList = response.choices.first.message.content;
    final String fullText = contentList?.map((item) => item.text is String ? item.text : json.encode(item.text)).join("\n") ?? "";
    final jsonPattern = RegExp(r'\{.*\}');
    final match = jsonPattern.firstMatch(fullText);

    if (match != null) {
      try {
        final jsonCommand = match.group(0);
        final decodedJson = json.decode(jsonCommand!);
        return {
          "text": fullText.replaceFirst(jsonCommand, "").trim(),
          "command": decodedJson
        };
      } catch (e) {
        return {"text": fullText};
      }
    } else {
      return {"text": fullText};
    }
  } catch (e) {
    return {"text": "Помилка: ${e.toString()}"};
  }
}
}