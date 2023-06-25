import 'package:dam_1c_2023/models/user.dart';
import 'package:dam_1c_2023/models/userService.dart';
import 'package:flutter/cupertino.dart';

class MockUserService extends ChangeNotifier implements UserService {
  UserModel? firebaseUser = UserModel(
      id: "1",
      name: "John",
      lastName: "Doe",
      email: "asdaaa@asdasd.aaa",);

  UserModel? get user => firebaseUser;
  String? get geterror => error;

  @override
  Future<void> getUserFromFirebase(String email) async{
    firebaseUser = UserModel(email: "user@itba.edu.ar", name: 'User', lastName: 'Model');
  }

  @override
  void clearError() {
    return;
  }

  @override
  Future<void> registerUser(String email, String name, String lastName, String password) async {
    return Future.value();
  }

  @override
  String? error;
  
  @override
  void logoutUser() {
    return;
  }
  
  @override
  Future<void> updateUser(UserModel newUser) {
    // TODO: implement updateUser
    return Future.value();
  }
  
  @override
  Future<void> updateVolunteeringId(int? volunteeringId) {
    // TODO: implement updateVolunteeringId
    return Future.value();
  }
  
  @override
  Future<bool> loginUser(String email, String password) {
    // TODO: implement loginUser
    return Future.value();
  }

}