class User {
  final String email;
  final String name;
  final String lastName;

  User(
      {required this.email,
      required this.name,
      required this.lastName});

  factory User.fromJson(Map<String, dynamic> json ){
    return User(
      email: json['email'], 
      name: json['name'], 
      lastName: json['lastName'],  
    );
  }

  static List<User> fromJsonArray(List<dynamic> jsonArray) {
    List<User> usersArray = [];
    jsonArray.forEach((element) { 
      usersArray.add(User.fromJson(element));
    });
    return usersArray;
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      'email': user.email,
      'name': user.name,
      'lastName': user.lastName
    };
  }
}
