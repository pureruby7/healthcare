import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthcare/domain/user.dart';
import 'package:healthcare/services/database.dart';

class AuthService{

  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _fAuth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      
      return User.fromFirebase(user);
    } catch(e){
      return null;
    }

  }

   Future<User> registerWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _fAuth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      
      //create id
      await DatabaseService(uid: user.uid).updateUserDate('meds', '01.08.2020', '08:34', 'blue', 4, 8, 'description');
      await DatabaseService(uid: user.uid).updateUsersDate('name', 'surname', 'description');

      return User.fromFirebase(user);
    } catch(e){
      print(e);
    }

  }

  Future logOut() async{
    await _fAuth.signOut();
  }

  Stream<User> get currentUser{
    return _fAuth.onAuthStateChanged.map((FirebaseUser user) => user != null ? User.fromFirebase(user): null);
  }

}