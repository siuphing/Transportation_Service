import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:transportservice/start_screen/startscreen.dart';
class Splashscreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenUI();
  }

}

class SplashScreenUI extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: StartScreen(),
      title: Text('Welcome',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0
        ),),
    );
  }
}
