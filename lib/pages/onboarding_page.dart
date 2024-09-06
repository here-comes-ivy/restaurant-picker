import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'auth_gate.dart';


class OnboardingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      headerBackgroundColor:Color.fromRGBO(237, 58, 39, 1),
      finishButtonText: 'Get started!',
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: Colors.black,
      ),
      skipTextButton: Text('Skip'),
      indicatorAbove: true,
      trailing: Text('Login'),
      trailingFunction: ()async{
        Navigator.push(context, MaterialPageRoute(builder: (context) => AuthPage()));
      },
      background: [
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Image.asset('assets/slide1.png', height:MediaQuery.of(context).size.height*0.6, width: MediaQuery.of(context).size.width,),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Image.asset('assets/slide2.png', height:MediaQuery.of(context).size.height*0.6, width: MediaQuery.of(context).size.width,),
        ),
      ],
      pageBackgroundColor: Color.fromRGBO(237, 58, 39, 1),
      totalPage: 2,
      speed: 1.8,
      onFinish: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AuthPage()));
      },
      pageBodies: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Not sure what to eat?',
                        textStyle: const TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                        ),
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    totalRepeatCount: 1,
                    pause: const Duration(milliseconds: 1),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Let WhatsForDinner tells you',
                        textStyle: const TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                        ),
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    totalRepeatCount: 1,
                    pause: const Duration(milliseconds: 10),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),
            ],
          ),
        ),
      ],
    );
  }
}
