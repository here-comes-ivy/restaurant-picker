import 'package:http/http.dart' as http;
import 'dart:convert';


class NetworkHelper {
  NetworkHelper(this.url);
  final url;

  Future getRestaurantData () async{  

    http.Response response = await http.get (url);

    if (response.statusCode == 200) {
        var decodedWeatherData = json.decode(response.body);
        return decodedWeatherData;

    } else {
        print("Error getting restaurant data: ${response.statusCode}");
    }
  }
}

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