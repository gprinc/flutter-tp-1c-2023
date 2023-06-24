import 'package:cloud_firestore/cloud_firestore.dart';
class UserModel {

  final String email;
  final String name;
  final String lastName;
  final int? volunteeringId;

  UserModel(
      {required this.email,
      required this.name,
      required this.lastName,
      this.volunteeringId});

  factory UserModel.fromJson(Map<String, dynamic> json ){
    return UserModel(
      email: json['email'], 
      name: json['name'], 
      lastName: json['lastName'],
      volunteeringId: json['volunteeringId']
    );
  }


  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(email: data['email'], name: data['name'], lastName: data['lastName'], volunteeringId: data['volunteeringId']);
  }

  static List<UserModel> fromJsonArray(List<dynamic> jsonArray) {
    List<UserModel> usersArray = [];
    jsonArray.forEach((element) {
      usersArray.add(UserModel.fromJson(element));
    });
    return usersArray;
  }

  static Map<String, dynamic> toJson(UserModel user) {
    return {
      'email': user.email,
      'name': user.name,
      'lastName': user.lastName,
      'volunteeringId': user.volunteeringId
    };
  }
}
