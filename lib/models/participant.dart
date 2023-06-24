import 'package:dam_1c_2023/models/user.dart';

enum Status {
  aceptado,
  rechazado,
  esperando,
}

class Participant {
  Status status;
  String email;

  Participant(
      {this.status = Status.esperando,
      required this.email});
  
  factory Participant.fromJson(Map<String, dynamic> json ){
    return Participant(
      status: json['status'],  
      email: json['email'],
    );
  }

  static List<Participant> fromJsonArray(List<dynamic> jsonArray) {
    List<Participant> participantsArray = [];
    jsonArray.forEach((element) { 
      participantsArray.add(Participant.fromJson(element));
    });
    return participantsArray;
  }

  static Map<String, dynamic> toJson(Participant user) {
    return {
      'status': user.status,
      'email': user.email,
    };
  }
}