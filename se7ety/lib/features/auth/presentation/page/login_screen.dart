import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/helper/app_regex.dart';
import 'package:se7ety/core/routes/navigations.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/core/widgets/custom_text_form_field.dart';
import 'package:se7ety/core/widgets/main_button.dart';
import 'package:se7ety/core/widgets/password_text_form_field.dart';
import 'package:se7ety/features/auth/data/user_type_enum.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.userType});
  final UserTypeEnum userType;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = true;

  String handleUserType() {
    return widget.userType == UserTypeEnum.doctor ? 'دكتور' : 'مريض';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: const BackButton(color: AppColors.primaryColor),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Column(
              children: [
                const Gap(40),
                Image.asset('assets/images/logo.png', height: 250),
                const SizedBox(height: 20),
                Text(
                  'سجل دخول الان كـ "${handleUserType()}"',
                  style: TextStyles.title.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: TextEditingController(),
                  hintText: 'Sayed@example.com',
                  prefixIcon: Icon(Icons.email_rounded),
                  textAlign: TextAlign.end,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'من فضلك ادخل الايميل';
                    } else if (!AppRegex.isEmailValid(value)) {
                      return 'من فضلك ادخل الايميل صحيحا';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 25.0),
                PasswordTextFormField(
                  controller: TextEditingController(),
                  hintText: '********',
                  prefixIcon: const Icon(Icons.lock),
                  validator: (value) {
                    if (value!.isEmpty) return 'من فضلك ادخل كلمة السر';
                    return null;
                  },
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsetsDirectional.only(top: 10, start: 10),
                  child: Text('نسيت كلمة السر ؟', style: TextStyles.small),
                ),
                const Gap(20),
                MainButton(
                  onPressed: () async {
                    // if (bloc.formKey.currentState!.validate()) {
                    //   bloc.add(LoginEvent(userType: widget.userType));
                    // }
                  },
                  text: "تسجيل الدخول",
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ليس لدي حساب ؟',
                        style: TextStyles.body.copyWith(
                          color: AppColors.darkColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          pushWithReplacement(
                            context,
                            Routes.signup,
                            extra: widget.userType,
                          );
                        },
                        child: Text(
                          'سجل الان',
                          style: TextStyles.body.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
