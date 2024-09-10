import 'package:http/http.dart' as http;
import 'dart:convert';

class GeminiService {
  final String apiKey;
  final String baseUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';

  GeminiService(this.apiKey);

  Future<String> generateResponse(String prompt) async {
    final response = await http.post(
      Uri.parse('$baseUrl?key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [{'parts': [{'text': prompt}]}],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['candidates'][0]['content']['parts'][0]['text'];
    } else {
      throw Exception('Failed to generate response');
    }
  }
}