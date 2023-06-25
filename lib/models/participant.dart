import 'package:dam_1c_2023/models/user.dart';

enum StatusITBA {
  aceptado,
  rechazado,
  esperando;

  String toJson() => name;
  static StatusITBA fromJson(String json) => values.byName(json);
}

class Participant {
  StatusITBA status;
  String email;

  Participant(
      {this.status = StatusITBA.esperando,
      required this.email});
  
  factory Participant.fromJson(Map<String, dynamic> json ){
    return Participant(
      status: StatusITBA.fromJson(json['status']),  
      email: json['email'],
    );
  }

  static List<Participant> fromJsonArray(List<dynamic> jsonArray) {
    if (jsonArray.isEmpty) return [];
    List<Participant> participantsArray = [];
    jsonArray.forEach((element) { 
      participantsArray.add(Participant.fromJson(element));
    });
    return participantsArray;
  }

  static Map<String, dynamic> toJson(Participant user) {
    return {
      'status': user.status.toJson(),
      'email': user.email,
    };
  }
}