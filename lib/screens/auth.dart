import 'package:flutter/material.dart';

class AutorizationPage extends StatefulWidget {
  AutorizationPage({Key key}) : super(key: key);

  @override
  AutorizationPageState createState() => AutorizationPageState();
}

class AutorizationPageState extends State<AutorizationPage> {

TextEditingController _emailControler = TextEditingController();
TextEditingController _passwordControler = TextEditingController();

String _email;
String _pass;
bool _showLogin = true;

  @override
  Widget build(BuildContext context) {
    Widget _logo() {
      return Padding(
        padding: EdgeInsets.only(top: 100),
        child: Container(
          child: Align(
            child: Text(
              'HealthCare',
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      );
    }

    Widget _input(Icon icon, String hint, TextEditingController controller, bool obsecure){
        return Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            controller: controller,
            obscureText: obsecure,
            style: TextStyle(fontSize: 20, color: Colors.white),
            decoration: InputDecoration(
              hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white30),
              hintText: hint,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3)
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white54, width: 1)
              ),
              prefixIcon: Padding(padding: EdgeInsets.only(left:10, right: 10), child: IconTheme(data: IconThemeData(color: Colors.white),
              child: icon),
            ),
          ),
        ),);
    }

    Widget _button(String text, void func()){
      return RaisedButton(
        splashColor: Theme.of(context).primaryColor,
        highlightColor: Theme.of(context).primaryColor ,
        color: Colors.white,
        child: Text(
          text,
          style: TextStyle(
          fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, 
          fontSize: 20
          )
        ),
        onPressed: (){
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
              child: _input(Icon(Icons.mail), "EMAIL", _emailControler, false),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: _input(Icon(Icons.lock), "PASSWORD", _passwordControler, true),
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


    void _loginUser(){
      _email = _emailControler.text;
      _pass = _passwordControler.text;

      _emailControler.clear();
      _passwordControler.clear();
    }

    

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: <Widget>[
            _logo(),
            (
              _showLogin
              ? Column( children: <Widget>[     
               _form("Login", _loginUser),
               Padding(
                 padding: EdgeInsets.all(10),
                 child: GestureDetector(
                 
                 child: Text('No registered yet? Register', style: TextStyle(fontSize: 20, color: Colors.white),),

                 onTap:() {
                   setState(() {
                     _showLogin = false;
                   });
                 }
                 ),)
              ],
              ): Column( children: <Widget>[     
               _form("Register", _loginUser),
               Padding(
                 padding: EdgeInsets.all(10),
                 child: GestureDetector(
                 
                 child: Text('Already registered? Login', style: TextStyle(fontSize: 20, color: Colors.white),),

                 onTap:() {
                   setState(() {
                     _showLogin = true;
                   });
                 }
                 ),)
              ],
              )

            )
          ],
        ));
  }
}

