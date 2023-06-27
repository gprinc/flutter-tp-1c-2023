import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String email;
  final String name;
  final String lastName;
  int? volunteeringId;
  String? birthDay;
  String? phoneNumber;
  final String? encodedPicture;
  String? gender;

  UserModel(
      {this.id,
      required this.email,
      required this.name,
      required this.lastName,
      this.volunteeringId,
      this.birthDay,
      this.phoneNumber,
      this.encodedPicture,
      this.gender});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json['email'],
        name: json['name'],
        lastName: json['lastName'],
        volunteeringId: json['volunteeringId'],
        birthDay: json['birthDay'],
        phoneNumber: json['phoneNumber'],
        encodedPicture: json['encodedPicture'],
        gender: json['gender']);
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: document.id,
        email: data['email'],
        name: data['name'],
        lastName: data['lastName'],
        volunteeringId: data['volunteeringId'],
        birthDay: data['birthDay'],
        phoneNumber: data['phoneNumber'],
        encodedPicture: data['encodedPicture'],
        gender: data['gender']);
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
      'volunteeringId': user.volunteeringId,
      'birthDay': user.birthDay,
      'phoneNumber': user.phoneNumber,
      'encodedPicture': user.encodedPicture,
      'gender': user.gender,
    };
  }

  hasCompleteProfile() {
    return phoneNumber != null && birthDay != null;
  }

  Map<String, dynamic> toJsonReduced() {
    return {
      'email': email,
      'name': name,
      'lastName': lastName,
      'volunteeringId': volunteeringId,
      'birthDay': birthDay,
      'phoneNumber': phoneNumber,
      'encodedPicture': encodedPicture,
      'gender': gender,
    };
  }
}
