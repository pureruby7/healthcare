import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthcare/domain/course.dart';
import 'package:healthcare/domain/user.dart';
class DatabaseService{

  final String uid;
  DatabaseService({this.uid});


    final CollectionReference courseCollection = Firestore.instance.collection('course');
  
  


  Future<void> updateUserDate(String meds, String startDay, String time, String color, int fullDay, int pausesDay, String description) async{
    return await courseCollection.document(uid).setData({
      'meds': meds,
      'startDay': startDay,
      'time': time,
      'color' : color,
      'fullDay' : fullDay,
      'pausesDay': pausesDay,
      'description': description,
    });
  }


  //list from snapshot course
  List<Course> _couseListFromSnapshot (QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
          return Course(
            meds : doc.data['meds'] ?? '',
            startDay: doc.data['startDay'] ?? '',
            time: doc.data['time'] ?? '',
            color : doc.data['color'] ?? '',
            fullDay: doc.data['fullDay'] ?? 0,
            pausesDay: doc.data['pausesDay'] ?? 0,
            description: doc.data['description'] ?? '',


          );
    }).toList();
  }
  
  //userdata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      meds: snapshot.data['meds'],
      startDay: snapshot.data['startDay'],
      time: snapshot.data['time'],
      color: snapshot.data['color'],
      fullDay: snapshot.data['fullDay'],
      pausesDay: snapshot.data['pausesDay'],
      description: snapshot.data['description'],

    );
  }


  //get stream course
  Stream<List<Course>> get course {
    return courseCollection.snapshots()
    .map(_couseListFromSnapshot);
  }


  //get user doc stream
  Stream<UserData> get userData{
    return courseCollection.document(uid).snapshots().
    map(_userDataFromSnapshot);
  }

  final CollectionReference userCollection = Firestore.instance.collection('user');
  
  


  Future<void> updateUsersDate(String name, String surname, String statuse) async{
    return await userCollection.document(uid).setData({
      'name': name,
      'surname': surname,
      'statuse': statuse,
    });
  }


  //list from snapshot course
  List<Profile> _userListFromSnapshot (QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
          return Profile(
            name: doc.data['name'] ?? '',
            surname: doc.data['surname'] ?? '',
            statuse: doc.data['statuse']?? '',

          );
    }).toList();
  }
  
  //userdata from snapshot
  ProfileData _usersDataFromSnapshot(DocumentSnapshot snapshot){
    return ProfileData(
      uid: uid,
      name: snapshot.data['name'],
      surname: snapshot.data['surname'],
      statuse: snapshot.data['statuse'],

    );
  }


  //get stream course
  Stream<ProfileData> get profileData{
    return courseCollection.document(uid).snapshots().
    map(_usersDataFromSnapshot);
  }



}