
import 'package:flutter/material.dart';
import 'package:healthcare/domain/user.dart';
import 'package:healthcare/screens/calendar.dart';
import 'package:healthcare/screens/home.dart';
import 'package:healthcare/screens/picCalendar.dart';
import 'package:healthcare/screens/settings_user_form.dart';
import 'package:healthcare/services/auth.dart';


class Pr extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  
  final Profile profile;
  _MyHomePageState({this.profile});
  int sectionIndex = 0;
  @override
  Widget build(BuildContext context) {
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new HomePage(),);
    void _showSettingsPanel() {
      showModalBottomSheet(
        isScrollControlled: true,
          context: context,
          builder: (context, ) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsUserForm(),
            );
          });
    }

    return  Scaffold(
        body: sectionIndex == 1 ? CalendarScreen() : sectionIndex == 2 ? Home() : Stack(
      children: <Widget>[
        ClipPath(
          child: Container(color: Color.fromRGBO(146, 213, 240, 1)),
          clipper: getClipper(),
        ),
        Positioned(
            width: 410.0,
            top: MediaQuery.of(context).size.height / 5,
            child: Column(
              children: <Widget>[
                Container(
                    width: 190.0,
                    height: 190.0,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        boxShadow: [
                          BoxShadow(blurRadius: 7.0, color: Colors.white)
                        ])),
                SizedBox(height: 20.0),
                Text(
                  'Max',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Health guys',
                  style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 25.0),
                Container(
                    height: 40.0,
                    width: 195.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Color.fromRGBO(58, 66, 156, 1),
                      color: Color.fromRGBO(58, 66, 156, 0.8),
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: () => _showSettingsPanel(),
                        child: Center(
                          child: Text(
                            'Edit Name',
                            style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                    )),
                    SizedBox(height: 25.0),
                Container(
                    height: 40.0,
                    width: 195.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.redAccent,
                      color: Colors.red,
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: () {
                        AuthService().logOut();
                       },
                        child: Center(
                          child: Text(
                            'Log out',
                            style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                    ))
              ],
            )
            ),
            
            //body: conteiner(),
            
      ],
      
    ),
    bottomNavigationBar: BottomNavigationBar(
     
      items: const <BottomNavigationBarItem>[
         BottomNavigationBarItem(
          icon:  Icon(Icons.home),
          title: Text("Profile"),
          backgroundColor: Colors.blue
        ),
         BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          title: Text("Calendar"),
          backgroundColor: Colors.blue

        ),
        BottomNavigationBarItem(
          icon:  Icon(Icons.list),
          title:  Text("Course"),
          backgroundColor: Colors.blue

        ),
      ],
      currentIndex: sectionIndex,
      onTap: (int index){
       setState(() => sectionIndex = index); 
      }
    ),
    
    );
    
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}