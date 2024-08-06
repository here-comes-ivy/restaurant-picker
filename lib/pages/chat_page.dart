// import 'package:flutter/material.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:intl/intl.dart';

// class ChatPage extends StatefulWidget {
//   const ChatPage({super.key});

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   TextEditingController _userInput = TextEditingController();

//   static const apiKey = "<Replace Your Gemini API Key Here>";

//   final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

//   final List<Message> _messages = [];

//   Future<void> sendMessage() async {
//     final message = _userInput.text;
//     _userInput.clear(); // 清空輸入框

//     setState(() {
//       _messages.insert(0, Message(isUser: true, message: message, date: DateTime.now()));
//     });

//     try {
//       final content = [Content.text(message)];
//       final response = await model.generateContent(content);

//       setState(() {
//         _messages.insert(0, Message(isUser: false, message: response.text ?? "", date: DateTime.now()));
//       });
//     } catch (e) {
//       // 錯誤處理
//       print('Error generating content: $e');
//       setState(() {
//         _messages.insert(0, Message(isUser: false, message: "Sorry, an error occurred.", date: DateTime.now()));
//       });
//     }
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/slide_1.jpg'),
//             fit: BoxFit.cover,
//             colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
//           )
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 reverse: true,
//                 itemCount: _messages.length,
//                 itemBuilder: (context, index) {
//                   final message = _messages[index];
//                   return Messages(
//                     isUser: message.isUser,
//                     message: message.message,
//                     date: DateFormat('HH:mm').format(message.date),
//                   );
//                 }
//               )
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 15,
//                     child: TextFormField(
//                       style: TextStyle(color: Colors.white),
//                       controller: _userInput,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         labelText: 'Enter Your Message',
//                         labelStyle: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   Spacer(),
//                   IconButton(
//                     padding: EdgeInsets.all(12),
//                     iconSize: 30,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.black,
//                       foregroundColor: Colors.white,
//                       shape: CircleBorder(),
//                     ),
//                     onPressed: sendMessage,
//                     icon: Icon(Icons.send)
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Message {
//   final bool isUser;
//   final String message;
//   final DateTime date;

//   Message({required this.isUser, required this.message, required this.date});
// }

// class Messages extends StatelessWidget {
//   final bool isUser;
//   final String message;
//   final String date;

//   const Messages({
//     Key? key,
//     required this.isUser,
//     required this.message,
//     required this.date
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(15),
//       margin: EdgeInsets.symmetric(vertical: 15).copyWith(
//         left: isUser ? 100 : 10,
//         right: isUser ? 10 : 100
//       ),
//       decoration: BoxDecoration(
//         color: isUser ? Colors.blueAccent : Colors.grey.shade400,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(10),
//           bottomLeft: isUser ? Radius.circular(10) : Radius.zero,
//           topRight: Radius.circular(10),
//           bottomRight: isUser ? Radius.zero : Radius.circular(10)
//         )
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             message,
//             style: TextStyle(fontSize: 16, color: isUser ? Colors.white : Colors.black),
//           ),
//           Text(
//             date,
//             style: TextStyle(fontSize: 10, color: isUser ? Colors.white : Colors.black),
//           )
//         ],
//       ),
//     );
//   }
// }