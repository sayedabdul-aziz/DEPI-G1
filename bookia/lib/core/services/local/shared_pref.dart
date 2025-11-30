import 'dart:convert';

import 'package:bookia/features/auth/domain/entities/auth_response/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences _pref;

  static const kUserData = "kUserData";
  static const kUserToken = "kUserToken";
  static const kWishlist = "kWishlist";

  static init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static setToken(String? value) {
    if (value == null) return;
    setData(kUserToken, value);
  }

  static String? getToken() {
    return getData(kUserToken);
  }

  static setUserData(User? user) {
    if (user == null) return;

    // object >> json (encode) >> string >> cache
    var objectToJson = user.toJson();
    setData(kUserData, objectToJson);
  }

  static User? getUserData() {
    var stringData = getData(kUserData);
    if (stringData == null) return null;

    // string >> json(decode) >> object
    var stringToJson = jsonDecode(stringData);
    var object = User.fromJson(stringToJson);
    return object;
  }

  static saveWishlist(List<int> wishlistIds) {
    // 2,3,4,5,6
    // List of int =>> list of string
    List<String> res = [];
    for (var id in wishlistIds) {
      res.add(id.toString());
    }
    setData(kWishlist, res);
  }

  static List<int>? getWishlist() {
    var list = getData(kWishlist);
    if (list == null) return null;

    List<int> res = [];
    for (var id in list) {
      res.add(int.parse(id));
    }
    return res;
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
