import 'package:dam_1c_2023/models/participant.dart';
import 'package:dam_1c_2023/models/user.dart';

class Volunteering {
  final String title;
  final String description;
  final String imageName;
  final String address;
  var requisites = [];
  var availability = [];
  final int id;
  List<dynamic> appliersEmail;
  List<dynamic> participantsEmail;

  Volunteering(
      {required this.title,
      required this.description,
      required this.imageName,
        required this.address,
      required this.requisites,
      required this.availability,
      required this.id,
      this.appliersEmail = const [],
        this.participantsEmail = const [],
      });

      factory Volunteering.fromJson(Map<String, dynamic> json ){
        return Volunteering(
          title: json['title'], 
          description: json['description'], 
          imageName: json['imageName'],
          address: json['address'],
          requisites: json['requisites'], 
          availability: json['availability'],
          id: json['id'],
          appliersEmail: json['appliersEmail'],
          participantsEmail: json['participantsEmail']
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
        'appliersEmail': appliersEmail,
        'participantsEmail': participantsEmail
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
        'appliersEmail': vol.appliersEmail,
        'participantsEmail': vol.participantsEmail
      };
  }
}
