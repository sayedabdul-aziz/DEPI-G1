import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences _pref;

  static const kUserData = "kUserData";
  static const kUserToken = "kUserToken";
  static const kWishlist = "kWishlist";

  static init() async {
    _pref = await SharedPreferences.getInstance();
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
