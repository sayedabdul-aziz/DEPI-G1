import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/constants/app_strings.dart';
import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.welcome,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 20,
            right: 20,
            top: 0,
            bottom: 0,
            child: Column(
              children: [
                Spacer(flex: 2),
                SvgPicture.asset(AppImages.logoSvg),
                const Gap(15),
                Text(
                  AppStrings.orderYourBookNow,
                  style: TextStyles.styleSize18,
                ),
                Spacer(flex: 4),
                MainButton(
                  label: AppStrings.login,
                  onPressed: () {
                    pushTo(context, Routes.login);
                  },
                ),
                const Gap(15),
                MainButton(
                  label: AppStrings.register,
                  bgColor: AppColors.backgroundColor,
                  textColor: AppColors.darkColor,
                  borderColor: AppColors.darkColor,
                  onPressed: () {
                    pushTo(context, Routes.register);
                  },
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
