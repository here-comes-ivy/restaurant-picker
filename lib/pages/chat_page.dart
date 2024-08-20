import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../components/chat_messageTile.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Content> _history = [];
  late final ChatSession _chat;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  bool _loading = false;
  static const _apiKey = 'AIzaSyDt-IJTvGWC75LnKxIfUI90SErWpePN8c4';

  @override
  void initState() {
    super.initState();
    _chat = GenerativeModel(model: 'gemini-pro', apiKey: _apiKey).startChat();
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    ));
  }

  Future<void> _sendMessage() async {
    final message = _textController.text.trim();
    if (message.isEmpty) return;

    setState(() {
      _history.add(Content('user', [TextPart(message)]));
      _loading = true;
      _textController.clear();
    });
    _scrollDown();

    try {
      final response = await _chat.sendMessage(Content.text(message));
      final responseText = response.text;
      if (responseText != null) {
        setState(() {
          _history.add(Content('model', [TextPart(responseText)]));
        });
      }
    } catch (e) {
      _showError('Error: ${e.toString()}');
    } finally {
      setState(() => _loading = false);
    }
    _scrollDown();
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ask AI Anything')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final content = _history[index];
                final text = content.parts.whereType<TextPart>().map((e) => e.text).join('');
                return MessageTile(
                  sendByMe: content.role == 'user',
                  message: text,
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
                    controller: _textController,
                    decoration: const InputDecoration(hintText: 'Ask me anything...'),
                  ),
                ),
                IconButton(
                  icon: _loading ? const CircularProgressIndicator() : const Icon(Icons.send),
                  onPressed: _loading ? null : _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}