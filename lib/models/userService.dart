import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_1c_2023/firebase/firebase_authentication.dart';
import 'package:dam_1c_2023/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dam_1c_2023/firebase/firebase_cloudstore.dart';

class UserService extends ChangeNotifier {

  UserITBA? _firebaseUser = null;
  String? error;

  UserITBA? get user => _firebaseUser;
  String? get geterror => error;

  Future<void> getUserFromFirebase(String email) async{
    var aux = await FirebaseCloudstoreITBA().db.collection('ser_manos_data').doc('users').get();
    Map<String, dynamic>? data = aux.data();
    var usersData = data?['values'] as List<dynamic>;
    usersData.forEach((element) {
      if(element['email'] == email) {
        _firebaseUser = UserITBA.fromJson(element);
      }
      return;
    });
  }

  void clearError() {
    error = null;
  }

  Future<void> registerUser(String email, String name, String lastName, String password) async {
    UserCredential? aux = await FirebaseAuthenticationITBA().registerUser(email, password);
    if (aux == null) {
      error = 'There was an error with the registration';
      return;
    }
    var document = await FirebaseCloudstoreITBA().db.collection('users').add(UserITBA.toJson(UserITBA(email: email, name: name, lastName: lastName)));
    _firebaseUser = UserITBA(email: email, name: name, lastName: lastName, id: document.id);
  }

  Future<void> loginUser(String email, String password) async {
    UserCredential? aux = await FirebaseAuthenticationITBA().loginUser(email, password);
    if (aux == null) {
      error = 'There was an error with the login';
      return;
    }
    final snapshot  = await FirebaseCloudstoreITBA().db.collection('users').where('email', isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserITBA.fromSnapshot(e)).single;
    _firebaseUser = userData;
  }

  void logoutUser() {
    _firebaseUser = null;
    FirebaseAuthenticationITBA().logout();
  }

  Future<void> updateUser(UserITBA newUser) async{
    await FirebaseCloudstoreITBA().db.collection('users').doc(_firebaseUser!.id).update(UserITBA.toJson(newUser));
  }
}
