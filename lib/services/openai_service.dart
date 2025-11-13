import 'dart:convert';
import 'package:gen_ai/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/message.dart';

class OpenAIService {
  final String apiKey;
  static const String baseUrl = 'http://192.168.0.5:1234/v1';

  OpenAIService({required this.apiKey});

  factory OpenAIService.fromEnv() {
    final apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
    if (apiKey.isEmpty) {
      throw Exception('OPENAI_API_KEY not found in .env file');
    }
    return OpenAIService(apiKey: apiKey);
  }

  Future<String> sendMessage({
    required List<Message> messages,
    String? model,
    double temperature = 0.7,
  }) async {
    final selectedModel = model ?? Constants.aiModel;
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/chat/completions'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'model': selectedModel,
          'messages': messages
              .map((msg) => {'role': msg.role.name, 'content': msg.content})
              .toList(),
          'temperature': temperature,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices'][0]['message']['content'] as String;
        return content.trim();
      } else {
        final error = jsonDecode(response.body);
        throw Exception('OpenAI API Error: ${error['error']['message']}');
      }
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  Stream<String> sendMessageStream({
    required List<Message> messages,
    String? model,
    double temperature = 0.7,
  }) async* {
    final selectedModel = model ?? Constants.aiModel;

    try {
      final request = http.Request(
        'POST',
        Uri.parse('$baseUrl/chat/completions'),
      );

      request.headers.addAll({'Content-Type': 'application/json'});
      request.body = jsonEncode({
        'model': selectedModel,
        'messages': messages
            .map((msg) => {'role': msg.role.name, 'content': msg.content})
            .toList(),
        'temperature': temperature,
        'stream': true,
      });

      final response = await request.send();

      if (response.statusCode == 200) {
        await for (var chunk in response.stream.transform(utf8.decoder)) {
          final lines = chunk.split('\n');
          for (var line in lines) {
            if (line.startsWith('data: ')) {
              final data = line.substring(6);
              if (data.trim() == '[DONE]') continue;
              try {
                final json = jsonDecode(data);
                final content = json['choices'][0]['delta']['content'];
                if (content != null) {
                  yield content as String;
                }
              } catch (_) {
                // Skip malformed JSON
              }
            }
          }
        }
      } else {
        throw Exception('OpenAI API Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to stream message: $e');
    }
  }
}
