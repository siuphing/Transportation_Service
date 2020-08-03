import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgetPassword3 extends StatefulWidget {
  @override
  _ForgetPassword3State createState() => _ForgetPassword3State();
}

class _ForgetPassword3State extends State<ForgetPassword3> {
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
        Text('please enter a new password ',
          style: TextStyle(
            fontFamily: 'Helvetica Neue',
            fontSize: 20,
            color: Colors.black,
          ),),
        SizedBox(height: 30,),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: TextFormField(
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              border: new OutlineInputBorder(
                borderRadius:new BorderRadius.circular(10),
                borderSide: new BorderSide(
                  color: Colors.blue,
                ),
              ),
              prefixIcon: Icon(Icons.lock_outline, size: 20, color: Colors.black26,),
              hintText:'New password ',
              hintStyle: TextStyle(fontFamily: 'Helvetica Neue',fontSize: 14,),
            ),
          ),
        ),
        SizedBox(height: 20,),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: TextFormField(
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              border: new OutlineInputBorder(
                borderRadius:new BorderRadius.circular(10),
                borderSide: new BorderSide(
                  color: Colors.blue,
                ),
              ),
              prefixIcon: Icon(Icons.lock_outline, size: 20, color: Colors.black26,),
              hintText:'Re-enter new password ',
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
                child:Text('Done',
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
