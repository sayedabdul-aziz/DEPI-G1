import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/routes/navigations.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // onboarding, welcome , patient main, doctor main

    User? user = FirebaseAuth.instance.currentUser;
    bool isOnboardingShown = SharedPref.isOnBoardingShown();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (user != null) {
        if (user.photoURL == "doctor") {
          // pushWithReplacement(context, Routes.doctorMain);
        } else {
          pushWithReplacement(context, Routes.patientMain);
        }
      } else {
        if (isOnboardingShown) {
          pushWithReplacement(context, Routes.welcome);
        } else {
          pushWithReplacement(context, Routes.onboarding);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(AppImages.logo, width: 250)),
    );
  }
}
