import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:restaurant_picker/utils/colorSetting.dart';
import '../components/chatPage/messageTile.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Content> history = [];
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFieldFocus = FocusNode();
  bool _loading = false;
  String geminiApiKey = dotenv.env['geminiApiKey']!; 

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: geminiApiKey,
    );
    _chat = _model.startChat();

        WidgetsBinding.instance.addPostFrameCallback((_) {
      setAIRole();
      sendAIGreeting();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask AI Anything'),
      ),
      body: Stack(
        children: [
          ListView.separated(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 90),
            itemCount: history.reversed.length,
            controller: _scrollController,
            reverse: true,
            itemBuilder: (context, index) {
              var content = history.reversed.toList()[index];
              var text = content.parts
                  .whereType<TextPart>()
                  .map<String>((e) => e.text)
                  .join('');
              return MessageTile(
                sendByMe: content.role == 'user',
                message: text,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 15,
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey.shade200))),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: TextField(
                        style: TextStyle(color: Colors.grey[900]),
                        cursorColor: Colors.grey,
                        controller: _textController,
                        focusNode: _textFieldFocus,
                        decoration: InputDecoration(
                            hintText: 'Ask me anything...',
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        history.add(
                            Content('user', [TextPart(_textController.text)]));
                      });
                      _sendChatMessage(_textController.text, history.length);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: appColors.onPrimary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(1, 1),
                                blurRadius: 3,
                                spreadRadius: 3,
                                color: Colors.black.withOpacity(0.05))
                          ]),
                      child: _loading
                          ? const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: CircularProgressIndicator.adaptive(
                                backgroundColor: Colors.white,
                              ),
                            )
                          : const Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                            ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.easeOutCirc,
      ),
    );
  }


Future<void> setAIRole() async {
    try {
      await _chat.sendMessage(Content.text(
        "You are a professional restaurant recommendation specialist. Your task is to help users find the right restaurant for them and answer their questions about various cuisines, ingredients, and cooking methods. You should be friendly, professional, and always ready to provide insightful suggestions and interesting food knowledge. If users ask questions that are not related to restaurants or food, please politely steer the conversation back to your area of expertise."
      ));
    } catch (e) {
      print("Error setting AI role: $e");
    }
  }


  Future<void> sendAIGreeting() async {
    setState(() {
      _loading = true;
    });

    try {
      var response = await _chat.sendMessage(Content.text(
        "With less than 30 words, please send a greeting as a restaurant recommendation specialist, briefly introduce your role, and ask what type of cuisine I am in the mood for today or if I have any special dining needs so you can provide the most suitable dining recommendations. Make sure to be friendly and approachable in your greeting."
      ));
      var greeting = response.text;
      if (greeting != null) {
        setState(() {
          history.add(Content('model', [TextPart(greeting)]));
          _loading = false;
        });
        _scrollDown();
      }
    } catch (e) {
      print("Error sending AI greeting: $e");
      setState(() {
        _loading = false;
        history.add(Content('model', [TextPart("Hello! I'm your AI dining assistant, here to help you discover restaurants you'll love. Based on your preferences and past choices, I’ve curated some personalized recommendations just for you. Let's find your next favorite spot!")]));
      });
      _scrollDown();
    }
  }

  Future<void> _sendChatMessage(String message, int historyIndex) async {
    setState(() {
      _loading = true;
      _textController.clear();
      _textFieldFocus.unfocus();
      _scrollDown();
    });

    List<Part> parts = [];

    try {
      var response = _chat.sendMessageStream(
        Content.text(message),
      );
      await for (var item in response) {
        var text = item.text;
        if (text == null) {
          _showError('No response from API.');
          return;
        } else {
          setState(() {
            _loading = false;
            parts.add(TextPart(text));
            if ((history.length - 1) == historyIndex) {
              history.removeAt(historyIndex);
            }
            history.insert(historyIndex, Content('model', parts));
          });
        }
      }
      await _chat.sendMessage(Content.text(
        "Please answer the questions as a restaurant recommendation specialist, with a professional yet friendly tone. Make sure all responses are focused on related to dining choices or related culinary information. Provide restaurant recommendations or food suggestions when appropriate."

      ));
    } catch (e, t) {
      print(e);
      print(t);
      _showError(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Something went wrong'),
          content: SingleChildScrollView(
            child: SelectableText(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }
}
