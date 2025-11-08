import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:se7ety/features/patient/booking/data/appointment_model.dart';

class FirestoreServices {
  static final CollectionReference doctorCollection = FirebaseFirestore.instance
      .collection('doctor');
  static final CollectionReference patientCollection = FirebaseFirestore
      .instance
      .collection('patient');
  static final CollectionReference appointmentCollection = FirebaseFirestore
      .instance
      .collection('appointment');

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

  static Future<void> createAppointment(AppointmentModel appointment) {
    return appointmentCollection.doc().set(appointment.toJson());
  }

  static Future<QuerySnapshot<Object?>> getAppointmentsByPatientId() {
    String id = FirebaseAuth.instance.currentUser?.uid ?? '';
    return appointmentCollection
        .orderBy('date', descending: false)
        .where('patientID', isEqualTo: id)
        .get();
  }

  static Future<void> deleteAppointment(String docID) {
    return appointmentCollection.doc(docID).delete();
  }
}
