import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/themes.dart';
import 'package:se7ety/firebase_options.dart';

abstract class Area {}

mixin Perimeter {}

class Circle extends Area with Perimeter {}

@override
getArea() {
  // TODO: implement getArea
  throw UnimplementedError();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: Locale('ar'),
      supportedLocales: [Locale('ar')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      routerConfig: Routes.routes,
      theme: AppThemes.lightTheme,
    );
  }
}
