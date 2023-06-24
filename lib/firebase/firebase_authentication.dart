import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationITBA {

  final _auth = FirebaseAuth.instance;
  late User? firebaseUser;
  
  @override
  void onReady() {
    firebaseUser = _auth.currentUser;
  }

  Future<UserCredential?> registerUser(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('Email is already in use.');
      }
      return null;
    } catch (e) {
      print(e);
    }
  }

  Future<UserCredential?> loginUser(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return null;
    }
  }

  void logout() async {
    await _auth.signOut();
  }
}