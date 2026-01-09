import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences _pref;

  static const konBoarding = "onBoarding";
  static const kIsDark = "isDark";

  static init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static setIsOnBoardingShown(bool value) {
    setData(konBoarding, value);
  }

  static bool isOnBoardingShown() {
    return _pref.getBool(konBoarding) ?? false;
  }

  static setIsDark(bool value) {
    setData(kIsDark, value);
  }

  static bool isDark() {
    return _pref.getBool(kIsDark) ?? false;
  }

  static setData(String key, dynamic value) {
    if (value is String) {
      _pref.setString(key, value);
    } else if (value is bool) {
      _pref.setBool(key, value);
    } else if (value is int) {
      _pref.setInt(key, value);
    } else if (value is double) {
      _pref.setDouble(key, value);
    } else if (value is List<String>) {
      _pref.setStringList(key, value);
    } else if (value is Map<String, dynamic>) {
      _pref.setString(key, jsonEncode(value));
    }
  }

  static getData(String key) {
    return _pref.get(key);
  }
}
