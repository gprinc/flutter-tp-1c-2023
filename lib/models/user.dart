class UserITBA {
  final String email;
  final String name;
  final String lastName;

  UserITBA(
      {required this.email,
      required this.name,
      required this.lastName});

  factory UserITBA.fromJson(Map<String, dynamic> json ){
    return UserITBA(
      email: json['email'], 
      name: json['name'], 
      lastName: json['lastName'],  
    );
  }

  static List<UserITBA> fromJsonArray(List<dynamic> jsonArray) {
    List<UserITBA> usersArray = [];
    jsonArray.forEach((element) { 
      usersArray.add(UserITBA.fromJson(element));
    });
    return usersArray;
  }

  static Map<String, dynamic> toJson(UserITBA user) {
    return {
      'email': user.email,
      'name': user.name,
      'lastName': user.lastName
    };
  }
}
