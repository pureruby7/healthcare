import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:healthcare/domain/user.dart';
import 'package:healthcare/screens/constants.dart';
import 'package:healthcare/screens/load.dart';
import 'package:healthcare/services/auth.dart';
import 'package:healthcare/services/database.dart';
import 'package:intl/intl.dart';
import 'dart:convert';


class CalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalendarScreenState();
  }
}

class _CalendarScreenState extends State<CalendarScreen> {
  void _handleNewDate(date) {
    setState(() {
      _selectedDay = date;
      _selectedEvents = _events[_selectedDay] ?? [];
    });
    print(_selectedEvents);
  }

  List _selectedEvents;
  DateTime _selectedDay;
  final Map<DateTime, List> _events = {

    DateTime(2020, 5, 7): [
      {'name': 'meds1', 'isDone': true},
    ],
    DateTime(2020, 5, 9): [
      {'name': 'meds1', 'isDone': true},
      {'name': 'meds2', 'isDone': true},
    ],
    DateTime(2020, 5, 10): [
      {'name': 'meds1', 'isDone': true},
      {'name': 'meds1', 'isDone': true},
    ],
    DateTime(2020, 5, 13): [
      {'name': 'meds2', 'isDone': true},
      {'name': 'meds2', 'isDone': true},
      {'name': 'meds3', 'isDone': false},
    ],
    DateTime(2020, 5, 25): [
      {'name': 'meds3', 'isDone': true},
      {'name': 'meds12', 'isDone': true},
      {'name': 'meds13', 'isDone': false},
    ],
    DateTime(2020, 6, 6): [
      {'name': 'meds13', 'isDone': false},
    ],
  };

  @override
  void initState() {
    super.initState();
    _selectedEvents = _events[_selectedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
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
            
          ],
        ),
      body: SafeArea(
        child: Column(
          
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            
            Container(
              
              child: Calendar(
                startOnMonday: true,
                weekDays: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
                events: _events,
                onRangeSelected: (range) =>
                    print("Range is ${range.from}, ${range.to}"),
                onDateSelected: (date) => _handleNewDate(date),
                isExpandable: true,
                eventDoneColor: Colors.green,
                selectedColor: Colors.pink,
                todayColor: Colors.yellow,
                eventColor: Colors.grey,
                dayOfWeekStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 11),
              ),
            ),
            _buildEventList()
          ],
        ),
      ),
    );
  }

  Widget _buildEventList() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Colors.black12),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
          child: ListTile(
            title: Text(_selectedEvents[index]['name'].toString()),
            onTap: () {},
          ),
        ),
        itemCount: _selectedEvents.length,
      ),
    );
  }
}