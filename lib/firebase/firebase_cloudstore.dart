import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCloudstoreITBA {
  late FirebaseFirestore db;

  FirebaseCloudstoreITBA() : db = FirebaseFirestore.instance;

  FirebaseCloudstoreITBA.withFirestore(FirebaseFirestore firebaseFirestore){
    db = firebaseFirestore;
  }

  Future<void> addData(String collection, Map<String, dynamic> data) async {
    await db.collection(collection).add(data);
    void addData(String collection, String docId, String innerCollection,
        Map<String, dynamic> data) async {
      await db.collection(collection).doc(docId)
          .collection(innerCollection)
          .add(data);
    }
  }

  Future<void> getData(String collection) async {
    await db.collection(collection).get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }

  Future<void> updateData(String collectionName, String id, Map<String, dynamic> data) async {
    var collection = db.collection(collectionName);
    await collection.doc(id).update(data);
  }
}
