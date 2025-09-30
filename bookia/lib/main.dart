import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/app_fonts.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

// BaseUrl
// Endpoint
// Request(Method, Body, Headers, Params)
// Response(Status, Body)
// http, dio

void main() {
  DioProvider.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: Routes.routes,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        fontFamily: AppFonts.dmSerifDisplayFamily,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        appBarTheme: AppBarTheme(backgroundColor: AppColors.backgroundColor),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          onSurface: AppColors.darkColor,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: AppColors.backgroundColor,
          type: BottomNavigationBarType.fixed,
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: AppColors.accentColor,
          filled: true,

          hintStyle: TextStyles.styleSize15.copyWith(
            color: AppColors.greyColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.borderColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.redColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.redColor),
          ),
        ),
      ),
      darkTheme: ThemeData(
        fontFamily: AppFonts.dmSerifDisplayFamily,
        scaffoldBackgroundColor: AppColors.darkColor,
        appBarTheme: AppBarTheme(backgroundColor: AppColors.backgroundColor),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          onSurface: AppColors.backgroundColor,
        ),
      ),
    );
  }
}
