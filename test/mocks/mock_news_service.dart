import 'package:dam_1c_2023/firebase/firebase_cloudstore.dart';
import 'package:dam_1c_2023/models/news.dart';
import 'package:dam_1c_2023/models/newsList.dart';
import 'package:flutter/material.dart';

class MockNewsProvider extends ChangeNotifier implements NewsList {
  
  @override
  bool loading = false;

  @override
  List<News> get news => _news;

  final List<News> _news = [
    News(
      header: 'REPORTE 2820',
      title: 'Ser donante voluntario',
      description:
          'Desde el Hospital Centenario recalcan la importancia de la donación voluntaria de Sangre',
      body:
          'En un esfuerzo por concienciar sobre la necesidad constante de sangre y sus componentes, el Hospital Centenario destaca la importancia de convertirse en un donante voluntario. La donación de sangre es un acto solidario y altruista que puede salvar vidas y mejorar la salud de aquellos que enfrentan enfermedades graves o accidentes.\n\nLa donación voluntaria de sangre desempeña un papel vital en el sistema de salud. A diferencia de la donación de sangre por reposición, donde se solicita a familiares y amigos donar para un paciente específico, la donación voluntaria se realiza sin ninguna conexión directa con un receptor particular. Esto garantiza un suministro constante y seguro de sangre y productos sanguíneos para todos aquellos que lo necesiten.\n\nLos beneficios de ser donante voluntario son numerosos. Además de la satisfacción de ayudar a quienes más lo necesitan, la donación de sangre tiene beneficios para la salud del propio donante. Al donar sangre, se realiza un chequeo médico que incluye pruebas para detectar enfermedades transmisibles, lo que puede proporcionar una evaluación temprana y ayuda en el diagnóstico de posibles problemas de salud.\n\n',
      imageName: 'assets/news_donar.png',
    ),
    News(
      header: 'NOTICIAS DE CUYO',
      title: 'Juntamos residuos',
      description:
          'Voluntarios de Godoy Cruz, se sumaron a la limpieza de un cauce en las inmediaciones.',
      body: '',
      imageName: 'assets/news_recolectar.png',
    ),
    News(
      header: 'DIARIO LA NACION',
      title: 'Adoptar mascotas',
      description:
          'Ayudanos a limpiar las calles de perros callejeros adoptándolos evitando la sobrepoblación de las perreras.',
      body: '',
      imageName: 'assets/news_adoptar.png',
    ),
    News(
      header: 'LA VOZ DEL INTERIOR',
      title: 'Preservamos la fauna',
      description:
          'Córdoba se une a la campaña del gobierno cuidar la fauna en época de sequía',
      body: '',
      imageName: 'assets/news_fauna.png',
    ),

    // Add more volunteerings here...
  ];
  
  @override
  void addNews(News news) {
    _news.add(news);
     Future.value();
  }
  
  @override
  Future<void> getFromFirebase() {
     return Future.value();
  }

  @override
  void setFirebaseCloudstore(FirebaseCloudstoreITBA firebaseCloudstore) {
    return;
  }
}