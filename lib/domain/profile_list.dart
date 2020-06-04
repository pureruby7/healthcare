import 'package:flutter/material.dart';
import 'package:healthcare/domain/user.dart';
import 'package:healthcare/screens/profile.dart';
import 'package:provider/provider.dart';


class ProfileList extends StatefulWidget {
  @override
  _ProfileListState createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
  @override
  Widget build(BuildContext context) {
          final  profile = Provider.of<List<Profile>>(context) ?? [];
          profile.forEach((profile){
              print(profile.name);
          });
        

    
        return ListView.builder(
      itemCount: profile.length,
      itemBuilder: (contex, index){
        //return Pr(profile: profile[index]);
       
        
      },
    );
  }
}