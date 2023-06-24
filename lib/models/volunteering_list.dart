import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_1c_2023/firebase/firebase_cloudstore.dart';
import 'package:flutter/material.dart';

import 'volunteering.dart';

class VolunteeringList extends ChangeNotifier {
  bool loading = false;
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

  VolunteeringList.withFirebaseCloudstore(FirebaseCloudstoreITBA firebaseCloudstoreITBA){
    _firebaseCloudstore = firebaseCloudstoreITBA;
  }

  VolunteeringList(){
    _firebaseCloudstore = FirebaseCloudstoreITBA();
  }

  final List<Volunteering> _firebaseVolunteerings = [];
  late FirebaseCloudstoreITBA _firebaseCloudstore;
  void setFirebaseCloudstore(FirebaseCloudstoreITBA firebaseCloudstore){
    _firebaseCloudstore = firebaseCloudstore;
  }

  List<Volunteering> get volunteering => _firebaseVolunteerings;

  Future<void> getFromFirebase() async{
    loading = true;
    var aux = await _firebaseCloudstore.db.collection('ser_manos_data').doc('voluntariados').get();
    Map<String, dynamic>? data = aux.data();
    var volunteersData = data?['values'] as List<dynamic>;
    volunteersData.forEach((element) {
      _firebaseVolunteerings.add(Volunteering.fromJson(element));
    });
    loading = false;
  }

  void addVolunteering(Volunteering volunteering) {
    _volunteering.add(volunteering);
    notifyListeners();
  }

  List<Volunteering> searchVolunteerings(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _volunteering.where((volunteering) {
      final lowercaseTitle = volunteering.title.toLowerCase();
      return lowercaseTitle.contains(lowercaseQuery);
    }).toList();
  }

  Future<void> updateFavorites(Volunteering vol, String email) async {
    List<Map<String, dynamic>> updatedList = [];
    _firebaseVolunteerings.forEach((element) {
      if (element.id == vol.id) {
        if(element.favoritos.contains(email))
          element.favoritos.remove(email);
        else
          element.favoritos.add(email);
      }
      updatedList.add(Volunteering.toJson(element));
    });
    await FirebaseCloudstoreITBA().db
      .collection('ser_manos_data')
      .doc('voluntariados')
      .update({ 'values': FieldValue.arrayUnion(updatedList)});
  }
}
