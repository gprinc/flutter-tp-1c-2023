import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCloudstoreITBA {
  final db = FirebaseFirestore.instance;

  void addData(String collection, String docId, String innerCollection, Map<String, dynamic> data) async {
    await db.collection(collection).doc(docId).collection(innerCollection).add(data);
  }

  void getData(String collection) async {
    await db.collection(collection).get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }

  void updateData(String collectionName, String id, Map<String, dynamic> data) async {
    var collection = db.collection(collectionName);
      collection 
          .doc(id)
          .update(data);
  }
}