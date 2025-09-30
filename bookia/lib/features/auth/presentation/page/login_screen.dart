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
import 'package:bookia/features/auth/presentation/widgets/social_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(),
      body: loginBody(),
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Don\'t have an account? ', style: TextStyles.styleSize15),
            TextButton(
              onPressed: () {
                pushReplacementTo(context, Routes.register);
              },
              child: Text('Register', style: TextStyles.styleSize15),
            ),
          ],
        ),
      ),
    );
  }

  Widget loginBody() {
    var cubit = context.read<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          pushAndRemoveUntil(
            context,
            Routes.main,
            extra: cubit.emailController.text,
          );
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
                Text(AppStrings.welcomeBack, style: TextStyles.styleSize30),
                const Gap(32),
                CustomTextFormField(
                  controller: cubit.emailController,
                  hintText: AppStrings.emailHint,
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
                  hintText: AppStrings.passwordHint,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      AppStrings.forgotPassword,
                      style: TextStyles.styleSize15,
                    ),
                  ),
                ),
                Gap(20),
                MainButton(
                  label: 'Login',
                  onPressed: () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.login();
                    }
                  },
                ),
                Gap(20),
                SocialLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
