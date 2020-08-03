import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transportservice/authentication/auth.dart';
import 'package:transportservice/database/user_db.dart';
import 'package:provider/provider.dart';
import 'package:transportservice/gmap.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().data,
      child: Scaffold(
        backgroundColor: Colors.red[50],
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('HomeScreen'),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(onPressed: () async {
              await _auth.SignOut();
              },
              icon: Icon(Icons.person), label: Text('Sign Out'),),
          ],
        ),
        body: Gmap(),

      ),
    );
  }
}
