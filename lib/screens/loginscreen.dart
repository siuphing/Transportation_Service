import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:transportservice/authentication/auth.dart';
import 'package:transportservice/authentication/google_auth.dart';
import 'package:transportservice/screens/homescreen.dart';
import 'package:transportservice/screens/testscreen.dart';
import 'package:transportservice/start_screen/startscreen.dart';

class LoginScreen extends StatefulWidget {

  final Function toggleView;
  LoginScreen({this.toggleView});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = "";
  String password = "";
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 30,right: 30),
        child: Column(
          children: <Widget>[
            _header(),
            _formInput(),
            _footer(),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            )
          ],
        ),
      ),
    );
  }


  Widget _header(){
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: <Widget>[
            Container(
              width: 290,
              height: 200,
              decoration: new BoxDecoration(
                image: new DecorationImage(image: new AssetImage("images/Image_icon.png")),
              ),
              child: Center(
                child: Text('Agency Services', style: TextStyle(
                  fontFamily: 'SF Pro Text',
                  fontSize: 25,
                  color: Colors.blue,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 1.0,
                      color: Color.fromARGB(145, 145, 145, 145),
                    )
                  ]
                ),),
              ),
            ),
          ],
        ),
        Text('Welcome!',
          style: TextStyle(
            fontFamily: 'Helvetica Neue',
            fontSize: 40,
            color: const Color (0xf5296af4),
          ),
        ),
        SizedBox(height: 10,),
        Text('Log in with your Email and Password',
          style: TextStyle(
            fontFamily: 'Helvetica Neue',
            fontSize: 12,
            color: const Color(0xff524949),
          ),
        )
      ],
    );
  }

  Widget _formInput(){
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: 25,),
          _email(),
          SizedBox(height: 20,),
          _password(),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text('Forgot Password?',
                style: TextStyle(
                  fontFamily: 'Helvetica Neue',
                  fontSize: 14,
                  color: const Color (0xf5296af4),
                ),)
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 186,
                height: 43,
                child: FlatButton(
                  color: const Color (0xf5296af4),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                  child:Text('Sign In ',
                    style: TextStyle(
                      fontFamily: 'Helvetica Neue',
                      fontSize: 19,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      dynamic reslut = await _auth.SignIn(email, password);
                      if(reslut == null){
                        setState(() => error = 'Could not sign in ');
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );

  }

  Widget _email(){
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue),
        ),
        prefixIcon: Icon(Icons.email, size: 20, color: Colors.black45,),
        hintText:'Enter email address',
        hintStyle: TextStyle(fontFamily: 'Helvetica Neue',fontSize: 14,),
      ),
      validator: (val) => val.isEmpty ? 'Enter an email' : null ,

      onChanged: (val){
        setState(() => email = val);
      },
    );
  }

  Widget _password(){
    return TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue),
        ),
        prefixIcon: Icon(Icons.lock, size: 20, color: Colors.black45,),
        hintText: 'Enter password',
        hintStyle: TextStyle(fontFamily: 'Helvetica Neue',fontSize: 14,),
      ),
      validator: (val) => val.length < 6 ? 'Enter a password 6+ character long ' : null ,
      onChanged: (val){
        setState(() => password = val);
      },
    );
  }

  Widget _footer(){
    return Column(
      children: <Widget>[
        SizedBox(height: 20,),
        Text('Or log in with ',
          style: TextStyle(
            fontFamily: 'Helvetica Neue',
            fontSize: 14,
            color: const Color(0xff524949),
          ),
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              decoration: new BoxDecoration(
                image: new DecorationImage(image: new AssetImage("images/facebook.png")),
              ),
            ),
            SizedBox(width: 15,),
            //TODO add user to database
            FlatButton(
              onPressed: () {
                signInWithGoogle();
//                    .whenComplete((){
//                  Navigator.of(context).push(
//                    MaterialPageRoute(
//                      builder: (context) {
//                        return TestScreen();
//                      },
//                    ),
//                  );
//                });
              },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(image: AssetImage("images/google.png"), height: 50.0),
                  ],
                ),
              ),
//            Container(
//              height: 50,
//              width: 50,
//              decoration: new BoxDecoration(
//                image: new DecorationImage(image: new AssetImage("images/google.png")),
//              ),
//            ),
          ],
        ),
        SizedBox(height: 20,),
        RichText(
          text: TextSpan(
              text: 'Dont have an account? ',
              style: TextStyle(
                fontFamily: 'Helvetica Neue',
                fontSize: 14,
                color: const Color(0xff524949),
              ),
              children: <TextSpan>[
                TextSpan(text: 'Sign up',
                  style: TextStyle(
                    fontFamily: 'Helvetica Neue',
                    fontSize: 14,
                    color: const Color (0xf5296af4),
                  ),
                    recognizer: TapGestureRecognizer()..onTap = () {
                    widget.toggleView();
                    },
                ),
              ]
          ),
        ),
      ],
    );

  }

}
