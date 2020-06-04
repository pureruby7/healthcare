import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/domain/user.dart';
import 'package:healthcare/screens/constants.dart';
import 'package:healthcare/screens/load.dart';
import 'package:healthcare/services/database.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:provider/provider.dart';


class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> color = ['blue', 'red', 'black', 'pink', 'green'];
  final List<String> pausesDay = ['0', '1', '2', '3', '4','5','6','7'];

  // form values
  String _currentMeds;
  String _currentStartDay;
  String _currentTime;
  String _currentColor;
  int _currentFullDay;
  int _currentPausesDay;
  String _currentDescription;
  DateTime _eventDate = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
              UserData userData = snapshot.data;
               TimeOfDay _startTime = TimeOfDay(hour:int.parse((userData.time).split(":")[0]),minute: int.parse((userData.time).split(":")[1]));
                String date = userData.startDay;
                String time = userData.time;
                  return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              
               SizedBox(height: 15.0),
              Text(
                'Update your course settings.',
                style: TextStyle(fontSize: 18.0),
              ),
               SizedBox(height: 15.0),
              TextFormField(
                initialValue: userData.meds,
                decoration: const InputDecoration(
                labelText: 'meds *',
              ),
                validator: (val) => val.isEmpty ? 'Please enter a meds' : null,
                onChanged: (val) => setState(() => _currentMeds = val),
              ), 
              
              SizedBox(height: 15.0),
              ListTile(
                    
                    title: Text("Date (YYYY-MM-DD)"),
                    subtitle: Text(
                        "$date"),
                    onTap: () async {
                      DateTime picked = await showDatePicker(
                          context: context,
                          initialDate: _eventDate,
                          firstDate: DateTime(_eventDate.year - 5),
                          lastDate: DateTime(_eventDate.year + 5));
                      if (picked != null) {
                        setState(() {
                          _eventDate = picked;
                        });
                      }
                      _currentStartDay = DateFormat('yyyy-MM-dd').format(picked);
                    }, 
                     
              ),
              ListTile(
                    title: Text("TIME (HH:MM)"),
                    subtitle: Text(
                        "$time"),
                    onTap: () async {
                          TimeOfDay pictime = await showTimePicker(
                          context: context,
                          initialTime: _time,
                          );
                          if (pictime != null) {
                        setState(() {
                          _time = pictime;
                        });
                        
                      }
                      String str = _time.toString();
                      const start = "TimeOfDay(";
                      const end = ")";

                      final startIndex = str.indexOf(start);
                      final endIndex = str.indexOf(end, startIndex + start.length);
                      _currentTime = str.substring(startIndex + start.length, endIndex);
                    }
                        
                      
              ),
                   
              
                SizedBox(height: 10.0),
              //dropdown
              DropdownButtonFormField(
                value: _currentColor ?? userData.color,
                items: color.map((color){
                  return DropdownMenuItem(
                    value: color, 
                    child: Text('$color color'),
                  );
                }).toList(), onChanged: (val) => setState(() => _currentColor = val),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                initialValue: userData.fullDay.toString(),
                decoration: const InputDecoration(
                labelText: 'full days *',
              ),
                validator: (val) => val.isEmpty ? 'Please enter a count of days' : null,
                onChanged: (val) => setState(() => _currentFullDay = int.parse(val)),
              ), 
              TextFormField(
                initialValue: userData.pausesDay.toString(),
                decoration:  const InputDecoration(
                labelText: 'Pauses days *',
              ),
                validator: (val) => val.isEmpty ? 'Please enter a count of days' : null,
                onChanged: (val) => setState(() => _currentPausesDay = int.parse(val)),
              ), 
             
              
              SizedBox(height: 10.0),

              TextFormField(

                initialValue: userData.description,
                decoration:  const InputDecoration(
                labelText: 'description *',
              ),
                validator: (val) => val.isEmpty ? 'Please enter a description' : null,
                onChanged: (val) => setState(() => _currentDescription = val),
              ),
              SizedBox(height: 10.0),
                
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                      await DatabaseService(uid: user.uid).updateUserDate(
                      _currentMeds ?? userData.meds,
                      _currentStartDay ?? userData,
                      _currentTime ?? userData.time,
                      _currentColor ?? userData.color,
                      _currentFullDay ?? userData.fullDay,
                      _currentPausesDay ?? userData.pausesDay,
                      _currentDescription ?? userData.description
                        );
                        Navigator.pop(context);
                  }
                  void addade(){
                      String meds = _currentMeds;
                      int fullDa = _currentFullDay;
                      String sD =_currentStartDay;
                      int pD =_currentPausesDay;
                      List<String> mylist = sD.split('-');
                  }
                  print(_currentMeds);
                  print( _currentStartDay);
                  print(_currentTime);
                  print(_currentColor);
                  print(_currentFullDay);
                  print(_currentPausesDay);
                  print(_currentDescription);
                },
              ) ,
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async{
                  int  i = 0 ;
                  if(_formKey.currentState.validate()){
                       stream: Firestore.instance.collection('course').document('${i}') .setData(
                         {
                            'meds': _currentMeds,
                            'startDay': _currentStartDay,
                            'time': _currentTime,
                            'color' : _currentColor,
                            'fullDay' : _currentFullDay,
                            'pausesDay': _currentPausesDay,
                            'description': _currentDescription,});
                        Navigator.pop(context);
                        i++;
                  }
                  
                },
              ) 
            ],
          ),
        );
        
        }else{
          return Loading();
        }

      }
    );
  }
}
