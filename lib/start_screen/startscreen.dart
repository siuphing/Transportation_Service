import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transportservice/authentication/authenticate.dart';
import 'package:transportservice/models/user.dart';
import 'package:transportservice/screens/homescreen.dart';
class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    if(user == null){
      return Authenticate();
    }else{
      return HomeScreen();
    }
  }
}
