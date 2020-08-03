import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:transportservice/authentication/auth.dart';

class SignupScreen extends StatefulWidget {

  final Function toggleView;
  SignupScreen({this.toggleView});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  bool _autoValidate = false;

  //text field state
  String _email = "";
  String _password = "";
  String _userName = "";
  String _phoneNumber = "";
  String error = '';

  bool _isHidden = true;

  void _togglePasswordVisibility(){
    setState(() {
      _isHidden = !_isHidden;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        leading: IconButton(
//          icon: Icon(Icons.arrow_back_ios, color: Colors.grey,),
//          onPressed: (){},
//        ),
//        backgroundColor: Colors.white,
//        title: Text('Sign Up',
//          style: TextStyle(
//            fontFamily: 'Helvetica Neue',
//            fontSize: 30,
//
//            color: const Color (0xf5296af4),
//          ),),
//        centerTitle: true,
//      ),
//      // resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 80, left: 30,right: 30),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _header(),
              SizedBox(height: 30,),
              _form(),
              _footer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(){
    return Row(
      children: <Widget>[
        Text('Sign Up',
          style: TextStyle(
            fontFamily: 'Helvetica Neue',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: const Color (0xf5296af4),
          ),),

      ],
    );
  }

  Widget _form(){
    return Form(
      key: _formKey,
//      autovalidate: _autoValidate,
      child: Column(
        children: <Widget>[
          _textField("Full Name"),
          SizedBox(height: 20,),
          _textField("Phone Number"),
          SizedBox(height: 20,),
          _textField("Email"),
          SizedBox(height: 20,),
          _textField("Password"),
          SizedBox(height: 20,),
          _textField("Confirm Password"),
          SizedBox(height: 20,),
          RichText(
            text: TextSpan(
                text: 'By signing up you accept the ',
                style: TextStyle(
                  fontFamily: 'Helvetica Neue',
                  fontSize: 14,
                  color: const Color(0xff524949),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Term of service',
                    style: TextStyle(
                      fontFamily: 'Helvetica Neue',
                      fontSize: 14,
                      color: const Color (0xf5296af4),
                    ),
                  ),
                  TextSpan(
                    text: ' and',
                    style: TextStyle(
                      fontFamily: 'Helvetica Neue',
                      fontSize: 14,
                      color: const Color(0xff524949),
                    ),
                  ),
                  TextSpan(
                    text: ' Privacy Policy',
                    style: TextStyle(
                      fontFamily: 'Helvetica Neue',
                      fontSize: 14,
                      color: const Color (0xf5296af4),
                    ),
                  ),
                ]
            ),
          ),
          Text(
            error,
            style: TextStyle(color: Colors.red, fontSize: 14.0),
          )
        ],

      ),
    );
  }

  Widget _textField( String hintText){
    return TextFormField(
      controller: hintText == "Password" ? _pass : hintText == "Confirm Password" ? _confirmPass : null,

      keyboardType: hintText == "Email" ? TextInputType.emailAddress : hintText == "Phone Number" ? TextInputType.phone : TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue),
        ),
        hintText: hintText,
        hintStyle: TextStyle(fontFamily: 'Helvetica Neue',fontSize: 16,),
        suffixIcon: hintText == "Password" ? IconButton(
          onPressed: _togglePasswordVisibility,
          icon: _isHidden ?  Icon(Icons.visibility_off,) : Icon(Icons.visibility),
        ): null,
      ),
      obscureText: hintText == "Password" ? _isHidden : hintText == "Confirm Password" ? true : false,

      validator: hintText == "Full Name" ? validateName : hintText == "Phone Number" ?
      validateMobile : hintText == "Email" ? validateEmail : hintText == "Password" ?
      validatePassword : hintText =="Confirm Password" ? validateConfirmPassword : null,

      onChanged: hintText == "Full Name" ? (value){setState(() {
        _userName = value;
      });} :
      hintText == "Phone Number" ? (value){setState(() {
        _phoneNumber = value;
      });} :
      hintText == "Email" ? (value){setState(() {
        _email = value;
      });} :
      hintText =="Confirm Password" ? (value){setState(() {
        _password = value;
      });} : null,
    );
  }

  Widget _footer(){
    return Column(
      children: <Widget>[
        SizedBox(height: 30,),
        Container(
          width: 303,
          height: 41,
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
                dynamic reslut = await _auth.SignUp(_email, _password,_userName,_phoneNumber);
                if(reslut == null){
                  setState(() { error = 'Please enter valid email';
//                  _autoValidate = true;
                  });
                }
              }
            },
          ),
        ),
        SizedBox(height: 20,),
        RichText(
          text: TextSpan(
              text: 'Already have an account? ',
              style: TextStyle(
                fontFamily: 'Helvetica Neue',
                fontSize: 14,
                color: const Color(0xff524949),
              ),
              children: <TextSpan>[
                TextSpan(text: 'Sign In',
                  style: TextStyle(
                    fontFamily: 'Helvetica Neue',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color (0xf5296af4),
                  ),
                  recognizer: TapGestureRecognizer()..onTap =() {
                    widget.toggleView();
                  }
                ),
              ]
          ),
        ),
      ],
    );
  }

  String validateName(String value) {
    if (value.length < 3)
      return 'Name must be more than 2 charater';
    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validateMobile(String value) {
    if (value.length < 2 )
      return 'Invalid Mobile Number';
    else
      return null;
  }

  String validatePassword( String value) {
    if(value.length == 0){
      return 'Password required !';
    }
      return null;
  }

  String validateConfirmPassword( String value) {
    if (value.length == 0) {
      return 'Please enter password again !';
    }
    if(value != _pass.text){
      return 'Password not match';
    }
    return null;
  }
}