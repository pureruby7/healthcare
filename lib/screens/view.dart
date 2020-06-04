import 'package:flutter/material.dart';

class EventDetailsPage extends StatelessWidget {


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Note details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            
            SizedBox(height: 20.0),
            Text('jjj')
          ],
        ),
      ),
    );
  }
}