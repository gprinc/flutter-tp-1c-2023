import 'package:flutter/material.dart';

import 'volunteering.dart';

class VolunteeringList extends ChangeNotifier {
  final List<Volunteering> _volunteering = [
    Volunteering(
      title: 'Un techo para mi país',
      description: 'Description for Un techo para mi país',
      imageName: 'assets/voluntariado.png',
    ),
    Volunteering(
      title: 'Manos caritativas',
      description: 'Description for Manos Caritativas',
      imageName: 'assets/manos.png',
    ),
    Volunteering(
      title: 'Iglesia',
      description: 'Description for Otro título',
      imageName: 'assets/iglesia.png',
    ),
    Volunteering(
      title: 'Un techo para mi país',
      description: 'Description for Un techo para mi país',
      imageName: 'assets/voluntariado.png',
    ),
    // Add more volunteerings here...
  ];

  List<Volunteering> get volunteering => _volunteering;

  void addVolunteering(Volunteering volunteering) {
    _volunteering.add(volunteering);
    notifyListeners();
  }
}
