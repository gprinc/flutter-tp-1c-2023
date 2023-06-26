import 'package:dam_1c_2023/firebase/firebase_cloudstore.dart';
import 'package:dam_1c_2023/models/newsList.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

import '../mocks/mock_news_service.dart';

void main() {
  test("get news", () async {
    final fakeFirestore = FakeFirebaseFirestore();

    // Mock firebase backend model
    final newsToInsert = MockNewsProvider().news[0].toJsonReduced();
    final newsArray = [];
    newsArray.add(newsToInsert);
    final firebaseData = {
      'values': newsArray
    };
    final documentReference = fakeFirestore.collection('ser_manos_data').doc('novedades');
    await documentReference.set(firebaseData);

    // Pass mocked firebase to api
    final firebaseCloudstore = FirebaseCloudstoreITBA.withFirestore(fakeFirestore);

    // Retrieve from firebase
    final newsList = NewsList.withFirebaseCloudstore(firebaseCloudstore);
    newsList.setFirebaseCloudstore(firebaseCloudstore);
    await newsList.getFromFirebase();
    final news = newsList.news;

    expect(news.length, 1);
    expect(news[0].title, 'Ser donante voluntario');
    // Add more assertions as needed
  });
}
