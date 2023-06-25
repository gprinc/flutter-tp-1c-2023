import 'package:dam_1c_2023/firebase/firebase_cloudstore.dart';
import 'package:dam_1c_2023/models/volunteering.dart';
import 'package:dam_1c_2023/models/volunteering_list.dart';
import 'package:flutter/cupertino.dart';

class MockVolunteeringList extends ChangeNotifier implements VolunteeringList {
  @override
  List<Volunteering> get volunteering => _volunteering;

  @override
  void addVolunteering(Volunteering volunteering) {
    _volunteering.add(volunteering);
  }

  @override
  Future<void> getFromFirebase() async {
    return Future.value();
  }

  List<Volunteering> searchVolunteerings(String query) {
    return _volunteering;
  }

  @override
  void setFirebaseCloudstore(FirebaseCloudstoreITBA firebaseCloudstoreITBA) {
    return;
  }

  final List<Volunteering> _volunteering = [
    Volunteering(
        title: 'Un techo para mi país',
        description:
            'El propósito principal de "Un techo para mi país" es reducir el déficit habitacional y mejorar las condiciones de vida de las personas que no tienen acceso a una vivienda adecuada.',
        imageName: 'assets/voluntariado.png',
        address: 'Corrientes 343',
        requisites: ['Mayor de edad', 'Poder levantar cosas pesadas'],
        availability: ['Lunes a viernes de 7 a 10hs'],
        id: 0,
        participants: []),
    Volunteering(
        title: 'Manos caritativas',
        description: 'Description for Manos Caritativas',
        imageName: 'assets/manos.png',
        address: 'Santa Fe 1432',
        requisites: ['Mayor de edad', 'Poder levantar cosas pesadas'],
        availability: ['Lunes a viernes de 7 a 10hs'],
        id: 1,
        participants: []),
    Volunteering(
        title: 'Iglesia',
        description: 'Description for Otro título',
        imageName: 'assets/iglesia.png',
        address: 'Av 9 de julio 2000',
        requisites: ['Mayor de edad', 'Poder levantar cosas pesadas'],
        availability: ['Lunes a viernes de 7 a 10hs'],
        id: 2,
        participants: []),
    Volunteering(
        title: 'Un techo para mi país',
        description: 'Description for Un techo para mi país',
        imageName: 'assets/voluntariado.png',
        address: 'Corrientes 343',
        requisites: ['Mayor de edad', 'Poder levantar cosas pesadas'],
        availability: ['Lunes a viernes de 7 a 10hs'],
        id: 3,
        participants: []),
    // Add more volunteerings here...
  ];

  @override
  late bool loading;
<<<<<<< HEAD

=======
>>>>>>> b55926a8acd16fe8101853fd0bdd8b20f41dd784
}
