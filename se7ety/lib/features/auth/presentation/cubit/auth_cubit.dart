import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialSate());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  login() {}

  register() async {
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

      await FirebaseFirestore.instance.collection("doctor").doc(user?.uid).set({
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "image": "",
        "phone": "",
        "address": "",
        "role": "doctor",
        "uid": user?.uid,
      });

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
}
