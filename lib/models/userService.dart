import 'package:dam_1c_2023/models/user.dart';
import 'package:flutter/material.dart';
import 'package:dam_1c_2023/firebase/firebase_cloudstore.dart';

class UserService extends ChangeNotifier {

  User? _firebaseUser = null;

  User? get user => _firebaseUser;

  Future<void> getUserFromFirebase(String email) async{
    var aux = await FirebaseCloudstoreITBA().db.collection('ser_manos_data').doc('users').get();
    Map<String, dynamic>? data = aux.data();
    var usersData = data?['values'] as List<dynamic>;
    usersData.forEach((element) {
      if(element['email'] == email) {
        _firebaseUser = User.fromJson(element);
      }
      return;
    });
  }
}
