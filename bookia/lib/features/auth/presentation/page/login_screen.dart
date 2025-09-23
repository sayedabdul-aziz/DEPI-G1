import 'package:bookia/core/constants/app_constants.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/constants/app_strings.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/auth/presentation/widgets/social_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      appBar: AppBar(
        automaticallyImplyLeading: false, // to remove the default back button
        centerTitle: false,
        title: SvgPicture.asset(AppImages.backSvg),
      ),
      body: Padding(
        padding: AppConstants.bodyPadding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(AppStrings.welcomeBack, style: TextStyles.styleSize30),
              const Gap(32),
              TextFormField(
                decoration: InputDecoration(hintText: AppStrings.emailHint),
              ),
              const Gap(15),
              TextFormField(
                decoration: InputDecoration(
                  hintText: AppStrings.passwordHint,
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [SvgPicture.asset(AppImages.eyeSvg)],
                  ),
                ),
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
              MainButton(label: 'Login', onPressed: () {}),
              Gap(20),
              SocialLogin(),
            ],
          ),
        ),
      ),
    );
  }
}
