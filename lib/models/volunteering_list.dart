import 'package:dam_1c_2023/firebase/firebase_cloudstore.dart';
import 'package:flutter/material.dart';

import 'volunteering.dart';

class VolunteeringList extends ChangeNotifier {
  bool loading = false;
  final List<Volunteering> _volunteering = [
    Volunteering(
        title: 'Un techo para mi país',
        about: 'Sobre un techo',
        description:
            'El propósito principal de "Un techo para mi país" es reducir el déficit habitacional y mejorar las condiciones de vida de las personas que no tienen acceso a una vivienda adecuada.',
        imageName: 'assets/voluntariado.png',
        address: 'Corrientes 343',
        requisites: ['Mayor de edad', 'Poder levantar cosas pesadas'],
        availability: ['Lunes a viernes de 7 a 10hs'],
        id: 0,
        appliersEmail: [],
        participantsEmail: []),
    Volunteering(
        title: 'Manos caritativas',
        about: 'Sobre manos',
        description: 'Description for Manos Caritativas',
        imageName: 'assets/manos.png',
        address: 'Santa Fe 1432',
        requisites: ['Mayor de edad', 'Poder levantar cosas pesadas'],
        availability: ['Lunes a viernes de 7 a 10hs'],
        id: 1,
        appliersEmail: [],
        participantsEmail: []),
    Volunteering(
        title: 'Iglesia',
        about: 'sobre otro titulo',
        description: 'Description for Otro título',
        imageName: 'assets/iglesia.png',
        address: 'Av 9 de julio 2000',
        requisites: ['Mayor de edad', 'Poder levantar cosas pesadas'],
        availability: ['Lunes a viernes de 7 a 10hs'],
        id: 2,
        appliersEmail: [],
        participantsEmail: []),
    Volunteering(
        title: 'Un techo para mi país',
        about: 'Sobre un techo',
        description: 'Description for Un techo para mi país',
        imageName: 'assets/voluntariado.png',
        address: 'Corrientes 343',
        requisites: ['Mayor de edad', 'Poder levantar cosas pesadas'],
        availability: ['Lunes a viernes de 7 a 10hs'],
        id: 3,
        appliersEmail: [],
        participantsEmail: []),
    // Add more volunteerings here...
  ];

  VolunteeringList.withFirebaseCloudstore(
      FirebaseCloudstoreITBA firebaseCloudstoreITBA) {
    _firebaseCloudstore = firebaseCloudstoreITBA;
  }

  VolunteeringList() {
    _firebaseCloudstore = FirebaseCloudstoreITBA();
  }

  final List<Volunteering> _firebaseVolunteerings = [];
  late FirebaseCloudstoreITBA _firebaseCloudstore;
  void setFirebaseCloudstore(FirebaseCloudstoreITBA firebaseCloudstore) {
    _firebaseCloudstore = firebaseCloudstore;
  }

  List<Volunteering> get volunteering => _firebaseVolunteerings;

  Future<void> getFromFirebase() async {
    loading = true;
    try {
      var aux = await _firebaseCloudstore.db
          .collection('ser_manos_data')
          .doc('voluntariados')
          .get();
      Map<String, dynamic>? data = aux.data();
      if (data != null) {
        _firebaseVolunteerings
            .clear(); // Clear the list before adding volunteerings
        var volunteersData = data['values'] as List<dynamic>;
        volunteersData.forEach((element) {
          print(element);
          _firebaseVolunteerings.add(Volunteering.fromJson(element));
        });
      }
      notifyListeners();
    } catch (error, stackTrace) {
      print('Error occurred during Firebase voluntariados retrieval: $error');
      print(stackTrace);
    } finally {
      loading = false;
    }
  }

  void addVolunteering(Volunteering volunteering) {
    _volunteering.add(volunteering);
    notifyListeners();
  }

  List<Volunteering> searchVolunteerings(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _firebaseVolunteerings.where((volunteering) {
      final lowercaseTitle = volunteering.title.toLowerCase();
      return lowercaseTitle.contains(lowercaseQuery);
    }).toList();
  }

  Future<void> updateFavorites(Volunteering vol, String email) async {
    List<Map<String, dynamic>> updatedList = [];
    _firebaseVolunteerings.forEach((element) {
      if (element.id == vol.id) {
        if (element.favoritos.contains(email))
          element.favoritos.remove(email);
        else
          element.favoritos.add(email);
      }
      updatedList.add(Volunteering.toJson(element));
    });
    await FirebaseCloudstoreITBA()
        .db
        .collection('ser_manos_data')
        .doc('voluntariados')
        .update({'values': updatedList});
    notifyListeners();
  }
}
