// import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';
import 'package:zaviato/components/screens/WelcomeScreen/WelcomeScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplash(
              imagePath: 'assets/common/demo.jpg',
              home: WelcomeScreen(),
              duration: 2500,
              type: AnimatedSplashType.StaticDuration,
            );
  }
}
