import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/domain/user.dart';
import 'package:healthcare/screens/constants.dart';
import 'package:healthcare/screens/load.dart';
import 'package:healthcare/services/database.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:provider/provider.dart';


class SettingsUserForm extends StatefulWidget {
  @override
  _SettingsUserFormState createState() => _SettingsUserFormState();
}

class _SettingsUserFormState extends State<SettingsUserForm> {
  final _formKey = GlobalKey<FormState>();
  // form values
  String _currentname;
  String _currentsurname;
  String _currentstatuse;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    
    return StreamBuilder<ProfileData>(
      stream: DatabaseService(uid: user.uid).profileData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
              ProfileData profileData = snapshot.data;
               
                  return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              
               SizedBox(height: 15.0),
              Text(
                'Update your profile',
                style: TextStyle(fontSize: 18.0),
              ),
               SizedBox(height: 15.0),
              TextFormField(
                initialValue: profileData.name,
                decoration: const InputDecoration(
                labelText: 'name *',
              ),
                validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                onChanged: (val) => setState(() => _currentname = val),
              ), 
              
              SizedBox(height: 15.0),
              TextFormField(
                initialValue: profileData.surname,
                decoration: const InputDecoration(
                labelText: 'surname *',
              ),
                validator: (val) => val.isEmpty ? 'Please enter a surname' : null,
                onChanged: (val) => setState(() => _currentsurname = val),
              ), 
              SizedBox(height: 20.0),
              SizedBox(height: 15.0),
              TextFormField(
                initialValue: profileData.surname,
                decoration: const InputDecoration(
                labelText: 'status *',
              ),
                validator: (val) => val.isEmpty ? 'Please enter a statuse' : null,
                onChanged: (val) => setState(() => _currentstatuse = val),
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
                      await DatabaseService(uid: user.uid).updateUsersDate(
                    _currentname ?? profileData.name,
                     _currentname ?? profileData.surname,
                     _currentstatuse ?? profileData.statuse,

                        );
                        Navigator.pop(context);
                  }
                  print(_currentname);
                  print( _currentsurname);
                  print(_currentstatuse);
                },
              ) ,
              
               
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
