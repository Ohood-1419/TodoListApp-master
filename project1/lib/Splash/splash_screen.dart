import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import '../Screens/Home/home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      nextScreen: HomePage(),
      splash: Column(children: [
        Image.asset('assets/logo.jpg'),
        Text(
          'Todo List App',
          style: TextStyle(
              color: Colors.black, fontSize: 33, fontFamily: 'Raleway'),
        ),
      ]),
      backgroundColor: Colors.white,
      splashIconSize: 200,
    );
  }
}
