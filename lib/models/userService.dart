import 'package:dam_1c_2023/firebase/firebase_authentication.dart';
import 'package:dam_1c_2023/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dam_1c_2023/firebase/firebase_cloudstore.dart';

class UserService extends ChangeNotifier {
  UserModel? _firebaseUser;
  String? error;

  UserModel? get user => _firebaseUser;
  String? get geterror => error;

  void clearError() {
    error = null;
  }

  Future<void> registerUser(
      String email, String name, String lastName, String password) async {
    UserCredential? aux =
        await FirebaseAuthenticationITBA().registerUser(email, password);
    if (aux == null) {
      error = 'There was an error with the registration';
      return;
    }
    UserModel auxUser = UserModel(email: email, name: name, lastName: lastName);
    await FirebaseCloudstoreITBA().db.collection('users').add(UserModel.toJson(
        auxUser));
    _firebaseUser = auxUser;
    notifyListeners();
  }

  Future<bool> loginUser(String email, String password) async {
    UserCredential? aux =
        await FirebaseAuthenticationITBA().loginUser(email, password);
    if (aux == null) {
      error = 'There was an error with the login';
      return false;
    }
    final snapshot = await FirebaseCloudstoreITBA()
        .db
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    _firebaseUser = userData;
    notifyListeners();
    return true;
  }

  void logoutUser() {
    _firebaseUser = null;
    FirebaseAuthenticationITBA().logout();
  }

  Future<void> updateUser(UserModel newUser) async {
    final userSnapshot = await FirebaseCloudstoreITBA()
        .db
        .collection('users')
        .where('email', isEqualTo: newUser.email).get();
    await FirebaseCloudstoreITBA().db.collection('users').doc(userSnapshot.docs[0].id).update(UserModel.toJson(newUser));
    // if (userSnapshot.docs.isNotEmpty) {
    //   final userDoc = userSnapshot.docs.first.reference;
    //   await FirebaseCloudstoreITBA().db.runTransaction((transaction) async {
    //     final userData = userSnapshot.docs.first.data();
    //     // Update or add the 'volunteeringId' field
    //     userData['birthDay'] = newUser.birthDay;
    //     userData['gender'] = newUser.gender;
    //     userData['phoneNumber'] = newUser.phoneNumber;
    //     transaction.set(userDoc, userData);
    //   });
    // }
    _firebaseUser = newUser;
    notifyListeners();
  }

  Future<void> updateVolunteeringId(int? volunteeringId) async {
      _firebaseUser!.volunteeringId = volunteeringId;
  }

  UserService.withFirebaseCloudstore(
      FirebaseCloudstoreITBA firebaseCloudstoreITBA) {
    _firebaseCloudstore = firebaseCloudstoreITBA;
  }

  UserService() {
    _firebaseCloudstore = FirebaseCloudstoreITBA();
  }

  late FirebaseCloudstoreITBA _firebaseCloudstore;
  void setFirebaseCloudstore(FirebaseCloudstoreITBA firebaseCloudstore) {
    _firebaseCloudstore = firebaseCloudstore;
  }
}
