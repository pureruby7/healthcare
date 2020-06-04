import 'package:healthcare/domain/course.dart';
import 'package:healthcare/domain/course_list.dart';
import 'package:healthcare/screens/settings_form.dart';
import 'package:healthcare/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
        isScrollControlled: true,
          context: context,
          builder: (context, ) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Course>>.value(
      value: DatabaseService().course,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Courses'),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  AuthService().logOut();
                },
                icon: Icon(
                  Icons.supervised_user_circle,
                  color: Colors.white,
                ),
                label: SizedBox.shrink()),
            FlatButton.icon(
                onPressed: () => _showSettingsPanel(),
                icon: Icon(Icons.settings,
                  color: Colors.white,),
                label: Text('setting',style: TextStyle(color: Colors.white),),)
          ],
        ),
        body: CourseList(),
      ),
    );
  }
}
