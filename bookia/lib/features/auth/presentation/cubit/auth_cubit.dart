import 'package:bookia/features/auth/data/models/auth_params.dart';
import 'package:bookia/features/auth/data/repo/auth_repo.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmationController = TextEditingController();

  register() async {
    emit(AuthLoadingState());
    var res = await AuthRepo.register(
      params: AuthParams(
        email: emailController.text,
        name: nameController.text,
        password: passwordController.text,
        passwordConfirmation: passwordConfirmationController.text,
      ),
    );
    if (res != null) {
      clearAllFields();
      emit(AuthSuccessState());
    } else {
      emit(AuthFailureState('Registration failed'));
    }
  }

  login() async {
    emit(AuthLoadingState());
    var res = await AuthRepo.login(
      params: AuthParams(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    if (res != null) {
      clearAllFields();
      emit(AuthSuccessState());
    } else {
      emit(AuthFailureState('Registration failed'));
    }
  }

  clearAllFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    passwordConfirmationController.clear();
  }
}
