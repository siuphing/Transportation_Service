import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgetPassword1 extends StatefulWidget {
  @override
  _ForgetPassword1State createState() => _ForgetPassword1State();
}

class _ForgetPassword1State extends State<ForgetPassword1> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 10,right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _header(),
              _body(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(){
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.arrow_back_ios),
            ),
            SizedBox(width: 10,),
            Text('Forgot password',
              style: TextStyle(
                fontFamily: 'Helvetica Neue',
                fontSize: 20,
                color: const Color (0xf5296af4),
              ),),
          ],
        ),
        SizedBox(height: 50,),
        Container(
          width: 274,
          height: 212,
          decoration: new BoxDecoration(
            image: new DecorationImage(image: new AssetImage("images/forgotpw.png")),
          ),
        )
      ],
    );
  }

  Widget _body(){
    return Column(
      children: <Widget>[
        SizedBox(height: 50,),
        Text('Please enter your registered email ',
          style: TextStyle(
            fontFamily: 'Helvetica Neue',
            fontSize: 20,
            color: Colors.black,
          ),),
        SizedBox(height: 10,),
        Text('We will send a verification code to your register email',
          style: TextStyle(
            fontFamily: 'Helvetica Neue',
            fontSize: 14,
            color: const Color (0xff524949),
          ),),
        SizedBox(height: 30,),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: new OutlineInputBorder(
                borderRadius:new BorderRadius.circular(10),
                borderSide: new BorderSide(
                  color: Colors.blue,
                ),
              ),

              prefixIcon: Icon(Icons.account_circle, size: 26, color: Colors.black,),
              hintText:'Email',
              hintStyle: TextStyle(fontFamily: 'Helvetica Neue',fontSize: 14,),
            ),
          ),
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width-20,
              height: 39,
              child: FlatButton(
                color: const Color (0xf5296af4),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30),
                ),
                child:Text('Next',
                  style: TextStyle(
                    fontFamily: 'Helvetica Neue',
                    fontSize: 19,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
