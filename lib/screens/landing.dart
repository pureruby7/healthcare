import 'package:flutter/material.dart';
import 'package:healthcare/domain/user.dart';
import 'package:healthcare/main.dart';
import 'package:healthcare/screens/calendar.dart';
import 'package:healthcare/screens/home.dart';
import 'package:healthcare/screens/log.dart';
import 'package:healthcare/screens/picCalendar.dart';
import 'package:healthcare/screens/profile.dart';
import 'package:provider/provider.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    final bool isLoggedId = user != null;

    return isLoggedId ? Pr() : MyHomePage();
  }
}