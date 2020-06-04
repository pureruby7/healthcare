import 'package:flutter/material.dart';
import 'package:healthcare/domain/course.dart';



class CourseTile extends StatelessWidget {
  final Course course;
  CourseTile({this.course});
  List<Color> colors = [Colors.blue, Colors.red, Colors.black, Colors.pink, Colors.green];
  
  
  @override
  Widget build(BuildContext context) {
    int index;
    if(course.color == 'blue'){
     index = 0;
  } else if(course.color == 'red'){
      index = 1;
  } else if(course.color == 'black'){
      index = 2;
  }else if(course.color == 'pink'){
      index = 3;
  }
  else if(course.color == 'green'){
      index = 4;
  }
  
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: colors[index],
            ),
            title: Text(course.meds),
            subtitle: Text('Takes ${course.fullDay} days'),
          ),
        ));
  }
}
