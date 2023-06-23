import 'package:dam_1c_2023/models/user.dart';

class Volunteering {
  final String title;
  final String description;
  final String imageName;
  var requisites = [];
  var availability = [];
  final int id;
  List<User> participants;

  Volunteering(
      {required this.title,
      required this.description,
      required this.imageName,
      required this.requisites,
      required this.availability,
      required this.id,
      this.participants = const [],});

      factory Volunteering.fromJson(Map<String, dynamic> json ){
        return Volunteering(
          title: json['title'], 
          description: json['description'], 
          imageName: json['imageName'], 
          requisites: json['requisites'], 
          availability: json['availability'],
          id: json['id'],
          participants: User.fromJsonArray(json['participants'])
        );
      }

      static Map<String, dynamic> toJson(Volunteering vol) {
        List<Map<String, dynamic>> auxParticipants = [];
        vol.participants.forEach((element) { 
          auxParticipants.add(User.toJson(element));
        });
      return {
        'title': vol.title,
        'description': vol.description,
        'imageName': vol.imageName,
        'requisites': vol.requisites,
        'availability': vol.availability,
        'id': vol.id,
        'participants': auxParticipants
      };
  }
}
