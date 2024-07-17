
import 'package:flutter/material.dart';
import 'package:restaurant_picker/utils/colorSetting.dart';
import 'spinner.dart';
import '/utils/responsiveSize.dart';

class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(decoration: BoxDecoration(
              image:DecorationImage(
                image: AssetImage('assets/slide_1.jpg'),
                fit: BoxFit.fill,
              )
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40, left: 40, right: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Not sure what to eat?'),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll <Color>(appColors.second),
                        foregroundColor:WidgetStatePropertyAll <Color>(Colors.white),
                      ),
                      onPressed: () {
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Spinner()),
                         */
                        showDialog(
                          context: context,
                          builder: (BuildContext){ 
                            return Dialog(
                              child: Container(
                                  width: ResponsiveSize.dialogWidth(context),
                                  height: ResponsiveSize.dialogHeight(context),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Let\'s have ... "),
                                      Expanded(
                                        child: Spinner(),
                                       ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          FloatingActionButton(
                                            onPressed: (){},
                                            child: Icon(Icons.refresh),
                                          ),
                                          FloatingActionButton(
                                            onPressed: (){},
                                            child: Icon(Icons.check),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                              ), 
                            );
                          },
                        );
                      },
                      child: Text("Let's roll!"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}
