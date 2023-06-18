import 'package:flutter/material.dart';

import 'volunteering.dart';

class VolunteeringList extends ChangeNotifier {
  final List<Volunteering> _volunteering = [
    Volunteering(
        title: 'Un techo para mi país',
        description:
            'El propósito principal de "Un techo para mi país" es reducir el déficit habitacional y mejorar las condiciones de vida de las personas que no tienen acceso a una vivienda adecuada.',
        imageName: 'assets/voluntariado.png',
        requisites: ['Mayor de edad', 'Poder levantar cosas pesadas'],
        availability: ['Lunes a viernes de 7 a 10hs']),
    Volunteering(
        title: 'Manos caritativas',
        description: 'Description for Manos Caritativas',
        imageName: 'assets/manos.png',
        requisites: ['Mayor de edad', 'Poder levantar cosas pesadas'],
        availability: ['Lunes a viernes de 7 a 10hs']),
    Volunteering(
        title: 'Iglesia',
        description: 'Description for Otro título',
        imageName: 'assets/iglesia.png',
        requisites: ['Mayor de edad', 'Poder levantar cosas pesadas'],
        availability: ['Lunes a viernes de 7 a 10hs']),
    Volunteering(
        title: 'Un techo para mi país',
        description: 'Description for Un techo para mi país',
        imageName: 'assets/voluntariado.png',
        requisites: ['Mayor de edad', 'Poder levantar cosas pesadas'],
        availability: ['Lunes a viernes de 7 a 10hs']),
    // Add more volunteerings here...
  ];

  List<Volunteering> get volunteering => _volunteering;

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
}
