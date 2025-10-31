import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  static final CollectionReference doctorCollection = FirebaseFirestore.instance
      .collection('doctor');
  static final CollectionReference patientCollection = FirebaseFirestore
      .instance
      .collection('patient');

  static Future<QuerySnapshot<Object?>> sortDoctorsByRate() {
    return doctorCollection.orderBy('rating', descending: true).get();
  }

  static Future<QuerySnapshot<Object?>> filterDoctorsBySpecialization(
    String specialization,
  ) {
    return doctorCollection
        .where('specialization', isEqualTo: specialization)
        .get();
  }

  static Future<QuerySnapshot<Object?>> searchDoctorsByName(String searchKey) {
    return doctorCollection.orderBy('name').startAt([searchKey]).endAt([
      '$searchKey\uf8ff',
    ]).get();
  }
}
