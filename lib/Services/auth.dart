import 'package:firebase_auth/firebase_auth.dart';
import 'package:irdc_attendance/Services/database.dart';

class Authservice {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get user {
    return _auth.authStateChanges();
  }

  Future sigout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  //sign in with email and password
  Future signinwithemailandpassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      User user = result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register using email and password
  Future registerwithemailandpassword(
      String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      User user = result.user;
      //create a document in firestore
      await DatabaseService(uid: user.uid).updateuserdata(name, 0);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //reset the password
  Future passwordreset(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email.trim());
    } catch (e) {}
  }
}
