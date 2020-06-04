import 'package:flutter/material.dart';
import 'package:healthcare/domain/user.dart';
import 'package:healthcare/screens/calendar.dart';
import 'package:healthcare/screens/home.dart';
import 'package:healthcare/screens/landing.dart';
import 'package:healthcare/screens/log.dart';
import 'package:healthcare/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().currentUser,
    
     child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
      )
    );
    
  }

}