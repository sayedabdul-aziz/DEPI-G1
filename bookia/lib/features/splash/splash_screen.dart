import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/constants/app_strings.dart';
import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    var isLoggedIn = SharedPref.getToken() != null;
    Future.delayed(Duration(seconds: 2), () {
      if (isLoggedIn) {
        pushReplacementTo(context, Routes.main);
      } else {
        pushReplacementTo(context, Routes.welcome);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImages.logoSvg),
            const Gap(10),
            Text(AppStrings.orderYourBookNow, style: TextStyles.styleSize18),
          ],
        ),
      ),
    );
  }
}
