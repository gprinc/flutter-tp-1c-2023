import 'dart:collection';

import 'package:dam_1c_2023/firebase/firebase_cloudstore.dart';
import 'package:dam_1c_2023/models/volunteering.dart';
import 'package:dam_1c_2023/models/volunteering_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

import '../mocks/mock_volunteering.dart';

void main() {
  test("get volunteerings", () async {
    final fakeFirestore = FakeFirebaseFirestore();

    // Mock firebase backend model
    final volunteeringsToInsert = MockVolunteeringList().volunteering[0].toJson();
    final volunteeringsArray = [];
    volunteeringsArray.add(volunteeringsToInsert);
    final firebaseData = {
      'values': volunteeringsArray
    };
    final documentReference = fakeFirestore.collection('ser_manos_data').doc('voluntariados');
    await documentReference.set(firebaseData);

    // Pass mocked firebase to api
    final firebaseCloudstore = FirebaseCloudstoreITBA.withFirestore(fakeFirestore);

    // Retrieve from firebase
    final volunteeringList = VolunteeringList.withFirebaseCloudstore(firebaseCloudstore);
    volunteeringList.setFirebaseCloudstore(firebaseCloudstore);
    await volunteeringList.getFromFirebase();
    final volunteerings = volunteeringList.volunteering;

    expect(volunteerings.length, 1);
    //expect(volunteerings[0].title, 'Un techo para mi país');
    // Add more assertions as needed
  });
}
