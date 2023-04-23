import 'package:flutter/material.dart';

import 'card_data.dart';

class CardList extends ChangeNotifier {
  final List<CardData> _cards = [
    CardData(
      title: 'Un techo para mi país',
      description: 'Description for Un techo para mi país',
      imageName: 'assets/voluntariado.png',
    ),
    CardData(
      title: 'Manos caritativas',
      description: 'Description for Manos Caritativas',
      imageName: 'assets/manos.png',
    ),
    CardData(
      title: 'Iglesia',
      description: 'Description for Otro título',
      imageName: 'assets/iglesia.png',
    ),
    // Add more cards here...
  ];

  List<CardData> get cards => _cards;

  void addCard(CardData cardData) {
    _cards.add(cardData);
    notifyListeners();
  }
}
