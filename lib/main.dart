import 'package:flutter/material.dart';
import 'pages/onBoarding.dart';
import 'utils/colorSetting.dart';
import 'pages/result.dart';
import 'pages/spinner.dart';


void main() => runApp(myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.dark, 
        ),
      ),
      home: Scaffold(
        body: Stack(
          children: [
            Opacity(
              opacity: 0.3,
              child: Image.asset(
                "assets/slide_2.jpg",
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: LandingPage(),
              ),
            ),
          ],    
        ),
      ),
    );
  }
}

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  Expanded button (Color color, String text, {VoidCallback? addonPressed}){
    return Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FilledButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(color), 
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => resultPage()),
                );
                addonPressed;
              }
            ),
          ),
        );
  }

  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                'Have you decided what to eat?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        button(
          Colors.amber, 
          'Surprise me!',
          
          ),
        button(Colors.grey, 'Have something in mind'),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
