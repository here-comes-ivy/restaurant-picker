import 'package:flutter/material.dart';
import 'profile.dart';
import 'spinner.dart';

class spinButton extends StatefulWidget {
  @override
  _spinButtonState createState() => _spinButtonState();
}

class _spinButtonState extends State<spinButton> {

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
                  MaterialPageRoute(builder: (context) => Spinner()),
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
