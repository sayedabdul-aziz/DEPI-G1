import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/services/firebase/firestore_services.dart';
import 'package:se7ety/core/widgets/doctor_card.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';

//* Firestore CRUD Operations Reference

//! get
// 1) specific document => collection.doc(id).get()
// 2) list of documents in collection:
// - all documents => collection.get()
// - all documents with live updates => collection.snapshots()
// - filtered documents => collection.where('field', isEqualTo: value).get()
// - searched documents => collection.startAt([value]).endAt([value + '\uf8ff']).get()
// - sorted documents => collection.orderBy('field', descending: true/false).get()
// - paginated documents => collection.limit(n).get()
// - combined queries => collection.where(...).orderBy(...).limit(n).get()

//! set
// create document => collection.doc(id/null).set(data)

//! update
// update document => collection.doc(id).update(data)

//! delete
// delete document => collection.doc(id).delete()

class TopRatedList extends StatefulWidget {
  const TopRatedList({super.key});

  @override
  State<TopRatedList> createState() => _TopRatedListState();
}

class _TopRatedListState extends State<TopRatedList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: FirestoreServices.sortDoctorsByRate(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                value: .9,
                color: Colors.black12,
              ),
            );
          } else {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data?.docs.length, // all doctors in firebase
              itemBuilder: (context, index) {
                DoctorModel doctor = DoctorModel.fromJson(
                  snapshot.data?.docs[index].data() as Map<String, dynamic>,
                );
                if (doctor.specialization == null ||
                    doctor.specialization?.isEmpty == true) {
                  return const SizedBox();
                }
                return DoctorCard(doctor: doctor);
              },
            );
          }
        },
      ),
    );
  }
}
