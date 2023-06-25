import 'package:dam_1c_2023/models/participant.dart';
import 'package:dam_1c_2023/models/user.dart';

class Volunteering {
  final String title;
  final String description;
  final String imageName;
  final String address;
  List<String> requisites = [];
  List<String> availability = [];
  final int id;
  List<String> participants;
  List<String> favoritos;

  Volunteering(
      {required this.title,
      required this.description,
      required this.imageName,
        required this.address,
      required this.requisites,
      required this.availability,
      required this.id,
      this.participants = const [],
      this.favoritos = const []});

      factory Volunteering.fromJson(Map<String, dynamic> json ){
        return Volunteering(
          title: json['title'], 
          description: json['description'], 
          imageName: json['imageName'],
          address: json['address'],
          requisites: List.from(['requisites']), 
          availability: List.from(json['availability']),
          id: json['id'],
          participants: List.from(json['participantsEmail']),
          favoritos: List.from(json['favoritos'])
        );
      }

    Map<String, dynamic> toJsonReduced() {
      return {
        'title': title,
        'description': description,
        'imageName': imageName,
        'address': address,
        'requisites': requisites,
        'availability': availability,
        'id': id,
        'participantsEmail': participants,
        'favoritos': favoritos
      };
    }

     static Map<String, dynamic> toJson(Volunteering vol) {
      return {
        'title': vol.title,
        'description': vol.description,
        'imageName': vol.imageName,
        'requisites': vol.requisites,
        'availability': vol.availability,
        'id': vol.id,
        'participantsEmail': vol.participants,
        'favoritos': vol.favoritos
      };
  }
}
