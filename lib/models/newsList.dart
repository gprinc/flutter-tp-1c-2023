import 'package:flutter/material.dart';

import '../firebase/firebase_cloudstore.dart';
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
      header: 'NOTICIAS DE CUYO',
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
      header: 'LA VOZ DEL INTERIOR',
      title: 'Preservamos la fauna',
      description:
          'Córdoba se une a la campaña del gobierno cuidar la fauna en época de sequía',
      imageName: 'assets/news_fauna.png',
    ),

    // Add more volunteerings here...
  ];

  final List<News> _firebaseNews = [];

  List<News> get news => _firebaseNews;

  Future<void> getFromFirebase() async{
    var aux = await FirebaseCloudstoreITBA().db.collection('ser_manos_data').doc('noticias').get();
    Map<String, dynamic>? data = aux.data();
    var volunteersData = data?['values'] as List<dynamic>;
    volunteersData.forEach((element) {
      _firebaseNews.add(News.fromJson(element));
    });
  }

  void addVolunteering(News news) {
    _news.add(news);
    notifyListeners();
  }
}
