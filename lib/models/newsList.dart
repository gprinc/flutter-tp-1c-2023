import 'package:flutter/material.dart';

import 'news.dart';

class NewsList extends ChangeNotifier {
  final List<News> _news = [
    News(
      header: 'REPORTE 2820',
      title: 'Ser donante voluntario',
      description:
          'Desde el Hospital Centenario recalcan la importancia de la donación voluntaria de Sangre',
      imageName: 'assets/news_donar.png',
    ),
    News(
      header: 'Noticias de Cuyo',
      title: 'Juntamos residuos',
      description:
          'Voluntarios de Godoy Cruz, se sumaron a la limpieza de un cauce en las inmediaciones.',
      imageName: 'assets/news_recolectar.png',
    ),
    News(
      header: 'DIARIO LA NACION',
      title: 'Adoptar mascotas',
      description:
          'Ayudanos a limpiar las calles de perros callejeros adoptándolos evitando la sobrepoblación de las perreras.',
      imageName: 'assets/news_adoptar.png',
    ),
    News(
      header: 'La voz del interior',
      title: 'Preservamos la fauna',
      description:
          'Córdoba se une a la campaña del gobierno cuidar la fauna en época de sequía',
      imageName: 'assets/news_fauna.png',
    ),

    // Add more volunteerings here...
  ];

  List<News> get news => _news;

  void addVolunteering(News news) {
    _news.add(news);
    notifyListeners();
  }
}