import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthcare/domain/user.dart';

import 'dart:math' as math;

import 'package:healthcare/services/auth.dart';
import 'package:provider/provider.dart';



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  TextEditingController _emailControler = TextEditingController();
  TextEditingController _passwordControler = TextEditingController();

  String _email;
  String _pass;
  bool _showLogin = true;

  AuthService _authService = AuthService();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.0,
      duration: Duration(seconds: 25),
      upperBound: 1,
      lowerBound: -1,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _input(Icon icon, String hint, TextEditingController controller,
        bool obsecure) {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: obsecure,
          style: TextStyle(fontSize: 20, color: Colors.black87),
          decoration: InputDecoration(
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black38),
            hintText: hint,
            focusedBorder: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Colors.black54, width: 3)),
            enabledBorder: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Colors.black45, width: 1)),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: IconTheme(
                  data: IconThemeData(color: Colors.black38), child: icon),
            ),
          ),
        ),
      );
    }

    Widget _button(String text, void func()) {
      return RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: Color.fromRGBO(20, 49, 99,1))),
        splashColor: Theme.of(context).primaryColor,
        highlightColor: Theme.of(context).primaryColor,
        color: Color.fromRGBO(146, 213, 240, 1),
        child: Text(text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              fontSize: 20,
            )),
        onPressed: () {
          func();
        },
      );
    }

    Widget _form(String lable, void func()) {
      return Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 10),
              child: _input(Icon(Icons.mail), "email", _emailControler, false),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: _input(
                  Icon(Icons.lock), "password", _passwordControler, true),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: _button(lable, func),
              ),
            )
          ],
        ),
      );
    }

    void _loginUser() {
      _email = _emailControler.text;
      _pass = _passwordControler.text;

      _emailControler.clear();
      _passwordControler.clear();
    }

    
    void _logUserAction() async{
      _email = _emailControler.text;
      _pass = _passwordControler.text;
      if(_email.isEmpty || _pass.isEmpty) return;

      User user = await _authService.signInWithEmailAndPassword(_email.trim(), _pass.trim());
      
      if(user == null){
        Fluttertoast.showToast(
        msg: "Can`t SignIn you! Please check your email/password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
      }else{
      _emailControler.clear();
      _passwordControler.clear();
      }

      
    }

    void _registerUserAction() async{
      _email = _emailControler.text;
      _pass = _passwordControler.text;
      if(_email.isEmpty || _pass.isEmpty) return;

      User user = await _authService.registerWithEmailAndPassword(_email.trim(), _pass.trim());
      
      if(user == null){
        Fluttertoast.showToast(
        msg: "Can`t Register you! Please check your email/password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
      }else{
      _emailControler.clear();
      _passwordControler.clear();
      }

      
    }

    var size = MediaQuery.of(context).size;
    // if (_controller.value == 0.8) _controller.reverse();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color.fromRGBO(245, 254, 255, 1),
      body: Column(children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return ClipPath(
                  clipper: DrawClip(_controller.value),
                  child: Container(
                    height: size.height * 0.35,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Color.fromRGBO(58, 66, 156, 1),
                            Color.fromRGBO(146, 213, 240, 1)
                          ]),
                    ),
                  ),
                );
              },
            ),
            Container(
              padding: EdgeInsets.only(bottom: 60),
              child: Text(
                'HealthCare',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 46,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        (_showLogin
            ? Column(
                children: <Widget>[
                  _form("Login", _logUserAction),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                        child: Text(
                          'No registered yet? Register',
                          style: TextStyle(fontSize: 20, color: Color.fromRGBO(20, 49, 99,1)),
                        ),
                        onTap: () {
                          setState(() {
                            _showLogin = false;
                          });
                        }),
                  )
                ],
              )
            : Column(
                children: <Widget>[
                  _form("Register", _registerUserAction),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                        child: Text(
                          'Already registered? Login',
                          style: TextStyle(fontSize: 20, color: Color.fromRGBO(20, 49, 99,1)),
                        ),
                        onTap: () {
                          setState(() {
                            _showLogin = true;
                          });
                        }),
                  )
                ],
              ))
      ]),
    );
  }
}

class DrawClip extends CustomClipper<Path> {
  double move = 0;
  double slice = math.pi;
  DrawClip(this.move);
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.8);
    double xCenter =
        size.width * 0.5 + (size.width * 0.6 + 1) * math.sin(move * slice);
    double yCenter = size.height * 0.8 + 69 * math.cos(move * slice);
    path.quadraticBezierTo(xCenter, yCenter, size.width, size.height * 0.8);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
