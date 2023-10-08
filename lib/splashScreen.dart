import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:property_sale/signup.dart';

void main()=>runApp(MaterialApp(home: splashScreen(),debugShowCheckedModeBanner: false,));

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  get userId => null;

  get password => null;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Center(
          child: AnimatedSplashScreen(
            splash: Text('Property Harbor'),
            nextScreen: LoginPage(userId: userId, password: password),
            duration: 100,
          ),
        ));

  }
}
