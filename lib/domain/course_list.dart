import 'package:flutter/material.dart';
import 'package:healthcare/domain/course.dart';
import 'package:healthcare/domain/course_tile.dart';
import 'package:provider/provider.dart';


class CourseList extends StatefulWidget {
  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {
          final course = Provider.of<List<Course>>(context) ?? [];
          
          course.forEach((course){
              print(course.meds);
          });

    return ListView.builder(
      itemCount: course.length,
      itemBuilder: (contex, index){
        return CourseTile(course: course[index]);
      },
    );
  }
}
