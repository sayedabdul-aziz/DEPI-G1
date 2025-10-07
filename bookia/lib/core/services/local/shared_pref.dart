import 'dart:convert';

import 'package:bookia/features/auth/data/models/auth_response/user.dart';
import 'package:bookia/features/wishlist/data/models/wishlist_response/datum.dart';
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

  static saveWishlist(List<WishlistProduct>? books) async {
    if (books == null) return;

    var listOfString = books.map((e) => jsonEncode(e.toJson())).toList();
    await _pref.setStringList(kWishlist, listOfString);
  }

  static List<WishlistProduct>? getWishlist() {
    var source = _pref.getStringList(kWishlist);
    if (source == null) return null;
    var listOfObj = source
        .map((e) => WishlistProduct.fromJson(jsonDecode(e)))
        .toList();
    return listOfObj;
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
