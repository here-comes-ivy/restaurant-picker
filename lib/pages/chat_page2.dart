import 'package:flutter/material.dart';
import '../services/networking.dart';
import '../services/places_service.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final GeminiService _geminiService = GeminiService('YOUR_GEMINI_API_KEY');
  final PlacesService _placesService = PlacesService('YOUR_PLACES_API_KEY');

  void _handleSubmitted(String text) async {
    _controller.clear();
    setState(() {
      _messages.add({'role': 'user', 'content': text});
    });

    try {
      String response = await _geminiService.generateResponse(text);
      
      if (response.contains('MAKE_RESERVATION')) {
        // 解析餐廳名稱
        String restaurantName = response.split('MAKE_RESERVATION:')[1].trim();
        // 這裡應該有一個函數來獲取 placeId，為簡化，我們假設直接使用餐廳名稱
        var details = await _placesService.getRestaurantDetails(restaurantName);
        response = '為您找到餐廳 ${details['name']}。\n電話: ${details['formatted_phone_number']}\n網站: ${details['website']}';
      }

      setState(() {
        _messages.add({'role': 'bot', 'content': response});
      });
    } catch (e) {
      print(e);
      setState(() {
        _messages.add({'role': 'bot', 'content': '抱歉，我遇到了一些問題。'});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AI Chatbot')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]['content']!),
                  leading: _messages[index]['role'] == 'user' ? Icon(Icons.person) : Icon(Icons.android),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: '輸入訊息...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}