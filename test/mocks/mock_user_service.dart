import 'package:dam_1c_2023/firebase/firebase_cloudstore.dart';
import 'package:dam_1c_2023/models/user.dart';
import 'package:dam_1c_2023/models/userService.dart';
import 'package:flutter/cupertino.dart';

class MockUserService extends ChangeNotifier implements UserService {
  UserModel? firebaseUser;

  @override
  UserModel? get user => firebaseUser;
  @override
  String? get geterror => error;


  @override
  Future<bool> loginUser(String email, String password) async {
    return Future.value(true);
  }

  @override
  void clearError() {
    return;
  }

  @override
  Future<void> registerUser(
      String email, String name, String lastName, String password) async {
    return Future.value();
  }

  @override
  String? error;

  @override
  void logoutUser() {
    return;
  }

  @override
  Future<void> updateUser(UserModel newUser) async {
    firebaseUser = UserModel(
        email: newUser.email,
        name: newUser.name,
        lastName: newUser.lastName,
        birthDay: newUser.birthDay,
        gender: newUser.gender,
        phoneNumber: newUser.phoneNumber);
    // throw UnimplementedError();
  }

  @override
  Future<void> updateVolunteeringId(int? volunteeringId) {
    // TODO: implement updateVolunteeringId
    throw UnimplementedError();
  }

  void resetUser(UserModel newUser) {
    firebaseUser = UserModel(
        email: "gprinc@itba.edu.ar", name: 'Guido', lastName: 'Princ');
  }

  @override
  void setFirebaseCloudstore(FirebaseCloudstoreITBA firebaseCloudstore) {
    return;
  }
}
