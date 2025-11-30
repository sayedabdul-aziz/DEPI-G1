import 'package:bookia/core/di/service_locator.dart';
import 'package:bookia/features/auth/domain/entities/auth_params.dart';
import 'package:bookia/features/auth/domain/usecases/login_use_case.dart';
import 'package:bookia/features/auth/domain/usecases/register_use_case.dart';
import 'package:bookia/features/auth/domain/usecases/verify_email_use_case.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthCubit({required this.loginUseCase, required this.registerUseCase})
    : super(AuthInitialState());

  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmationController = TextEditingController();

  final verifyEmailUseCase = gi<VerifyEmailUseCase>();

  register() async {
    emit(AuthLoadingState());
    var res = await registerUseCase.call(
      params: AuthParams(
        email: emailController.text,
        name: nameController.text,
        password: passwordController.text,
        passwordConfirmation: passwordConfirmationController.text,
      ),
    );
    res.fold(
      (left) {
        emit(AuthFailureState(left.errorMessage));
      },
      (data) {
        emit(AuthSuccessState());
      },
    );
  }

  login() async {
    emit(AuthLoadingState());
    var res = await loginUseCase.call(
      params: AuthParams(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    res.fold(
      (left) {
        emit(AuthFailureState(left.errorMessage));
      },
      (data) {
        emit(AuthSuccessState());
      },
    );
  }
}
