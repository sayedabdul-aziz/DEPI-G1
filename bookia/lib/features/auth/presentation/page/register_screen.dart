import 'package:bookia/core/constants/app_constants.dart';
import 'package:bookia/core/constants/app_strings.dart';
import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/app_bar_with_back.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/password_text_form_field.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(),
      body: registerBody(),
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Already have an account? ', style: TextStyles.styleSize15),
            TextButton(
              onPressed: () {
                pushReplacementTo(context, Routes.login);
              },
              child: Text('Login', style: TextStyles.styleSize15),
            ),
          ],
        ),
      ),
    );
  }

  Widget registerBody() {
    var cubit = context.read<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          pushAndRemoveUntil(context, Routes.main);
        } else if (state is AuthFailureState) {
          pop(context);
          showErrorDialog(context, state.error);
        } else if (state is AuthLoadingState) {
          showLoadingDialog(context);
        }
      },
      child: Padding(
        padding: AppConstants.bodyPadding,
        child: SingleChildScrollView(
          child: Form(
            key: cubit.formKey,
            child: Column(
              children: [
                Text(
                  AppStrings.registerToGetStarted,
                  style: TextStyles.styleSize30,
                ),
                const Gap(32),
                CustomTextFormField(
                  controller: cubit.nameController,
                  hintText: AppStrings.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const Gap(15),
                CustomTextFormField(
                  controller: cubit.emailController,
                  hintText: AppStrings.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const Gap(15),
                PasswordTextFormField(
                  controller: cubit.passwordController,
                  hintText: AppStrings.password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const Gap(15),
                PasswordTextFormField(
                  controller: cubit.passwordConfirmationController,
                  hintText: AppStrings.password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),

                Gap(30),
                MainButton(
                  label: 'Register',
                  onPressed: () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.register();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
