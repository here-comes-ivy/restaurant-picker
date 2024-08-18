import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'login_page.dart';
import 'registration_page.dart';
import '../components/roundButton.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      headerBackgroundColor: Colors.white,
      finishButtonText: 'Register',
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: Colors.black,
      ),
      skipTextButton: Text('Skip'),
      trailing: Text('Login'),
      background: [
        Image.asset('assets/slide_3.jpg'),
        Image.asset('assets/slide_4.jpg'),
      ],
      totalPage: 2,
      speed: 1.8,
      onFinish: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => RegistrationPage()));
      },
      pageBodies: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              Text('Description Text 1'),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('assets/app_icon.png'),
                      height: 60.0,
                    ),
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Not sure what to eat?',
                        textStyle: const TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.bold,
                        ),
                        speed: const Duration(milliseconds: 2000),
                      ),
                    ],
                    totalRepeatCount: 4,
                    pause: const Duration(milliseconds: 1000),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),
                  
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              RoundButton(
                title: 'Log In',
                color: Colors.lightBlueAccent,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
              RoundButton(
                title: 'Register',
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationPage()));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
