import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign In
  Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      return e.toString(); 
      }
  }


  Future<String?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return null; 
    } catch (e) {
      return e.toString();
    }
  }


  Future<void> signOut() async {
    await _auth.signOut();
  }


  User? getCurrentUser() {
    return _auth.currentUser;
  }

}