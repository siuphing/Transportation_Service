import 'package:firebase_auth/firebase_auth.dart';
import 'package:transportservice/database/user_db.dart';
import 'package:transportservice/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object base on firebaseUser

  User _userfromFirebaseUser (FirebaseUser user){
    return user != null ? User(uid: user.uid) : null ;
  }
  // auth change user stream
//  Stream<FirebaseUser> get user {
//    return _auth.onAuthStateChanged;   //return firebaseuser
//  }

  Stream<User> get user { //return custom user
    return _auth.onAuthStateChanged
//        .map((FirebaseUser user )=> _userfromFirebaseUser(user));
        .map(_userfromFirebaseUser);
  }

  //sign in anonymously
//  Future SignInAnon() async {
//    try{
//      AuthResult result = await _auth.signInAnonymously();
//      FirebaseUser user = result.user;
//      return _userfromFirebaseUser(user);
//    }catch(e){
//      print(e.toString());
//      return null;
//    }
//  }

  //sign in with email & password
  Future SignIn( String email , String password ) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userfromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //register with email & password
  Future SignUp( String email , String password, String username, String phoneNumber ) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password).catchError((e) => print(e));
      FirebaseUser user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(username, email, phoneNumber);

      return _userfromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //sign out
  Future SignOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}