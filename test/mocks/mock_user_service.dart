import 'package:dam_1c_2023/models/user.dart';
import 'package:dam_1c_2023/models/userService.dart';
import 'package:flutter/cupertino.dart';

class MockUserService extends ChangeNotifier implements UserService {
  UserModel? firebaseUser;

  UserModel? get user => firebaseUser;
  String? get geterror => error;

  @override
  Future<void> getUserFromFirebase(String email) async {
    firebaseUser =
        UserModel(email: "user@itba.edu.ar", name: 'User', lastName: 'Model');
  }

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
}
