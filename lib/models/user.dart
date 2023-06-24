class UserModel {
  final String email;
  final String name;
  final String lastName;

  UserModel(
      {required this.email,
      required this.name,
      required this.lastName});

  factory UserModel.fromJson(Map<String, dynamic> json ){
    return UserModel(
      email: json['email'], 
      name: json['name'], 
      lastName: json['lastName'],  
    );
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
      'lastName': user.lastName
    };
  }
}
