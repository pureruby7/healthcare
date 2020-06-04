import 'package:firebase_auth/firebase_auth.dart';

class User {
  String uid;

  User.fromFirebase(FirebaseUser user) {
    uid = user.uid;
  }
}

class UserData {
  final String uid;
  final String meds;
  final String startDay;
  final String time;
  final String color;
  final int fullDay;
  final int pausesDay;
  final String description;
  UserData(
      {this.uid,
      this.meds,
      this.startDay,
      this.time,
      this.color,
      this.fullDay,
      this.pausesDay,
      this.description});
}

class ProfileData {
  final String uid;
  final String name;
  final String surname;
  final String statuse;

  ProfileData({this.uid, this.name, this.surname, this.statuse});
}

class Profile {
  final String name;
  final String surname;
  final String statuse;
  Profile({this.name, this.surname, this.statuse});
}
