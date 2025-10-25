import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';
import 'package:se7ety/features/auth/data/user_type_enum.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialSate());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? imageUrl;
  String? specialization;

  final bioController = TextEditingController();
  final addressController = TextEditingController();
  final phone1Controller = TextEditingController();
  final phone2Controller = TextEditingController();
  final openHourController = TextEditingController();
  final closeHourController = TextEditingController();

  login() async {
    emit(AuthLoadingState());
    try {
      var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      emit(AuthSuccessState(role: credential.user?.photoURL));
    } catch (e) {
      emit(AuthErrorState(message: 'حدث خطأ ما'));
    }
  }

  register({required UserTypeEnum userType}) async {
    emit(AuthLoadingState());
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
      User? user = credential.user;
      user?.updateDisplayName(nameController.text);

      // Collection => list of docs , every doc (id, data)

      if (userType == UserTypeEnum.doctor) {
        //! user photoURL as Role (doctor , patient)
        user?.updatePhotoURL('doctor');
        var doctor = DoctorModel(
          uid: user?.uid,
          name: nameController.text,
          email: emailController.text,
        );
        await FirebaseFirestore.instance
            .collection("doctor")
            .doc(user?.uid)
            .set(doctor.toJson());
      } else {
        user?.updatePhotoURL('patient');
        var patient = PatientModel(
          uid: user?.uid,
          name: nameController.text,
          email: emailController.text,
        );
        await FirebaseFirestore.instance
            .collection("patient")
            .doc(user?.uid)
            .set(patient.toJson());
      }

      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthErrorState(message: 'كلمة المرور ضعيفة'));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthErrorState(message: 'البريد الالكتروني مستخدم بالفعل'));
      } else {
        emit(AuthErrorState(message: 'حدث خطأ ما'));
      }
    } catch (e) {
      emit(AuthErrorState(message: 'حدث خطأ ما'));
    }
  }

  updateDoctorData() async {
    emit(AuthLoadingState());
    var doctor = DoctorModel(
      uid: FirebaseAuth.instance.currentUser?.uid,
      bio: bioController.text,
      address: addressController.text,
      phone1: phone1Controller.text,
      phone2: phone2Controller.text,
      openHour: openHourController.text,
      closeHour: closeHourController.text,
      specialization: specialization,
      image: imageUrl,
      rating: 3,
    );
    try {
      await FirebaseFirestore.instance
          .collection("doctor")
          .doc(doctor.uid)
          .update(doctor.toUpdateData());
      emit(AuthSuccessState());
    } on Exception catch (_) {
      emit(AuthErrorState(message: 'حدث خطأ ما'));
    }
  }
}
