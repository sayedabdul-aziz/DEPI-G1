import 'dart:developer';

import 'package:bookia/core/services/api/api_endpoints.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/data/models/auth_params.dart';
import 'package:bookia/features/auth/data/models/auth_response/auth_response.dart';

// p = PERSON();
// Map=> p.toJson;

class AuthRepo {
  static Future<AuthResponse?> register({required AuthParams params}) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.register,
        data: params.toJson(),
      );
      if (res.statusCode == 201) {
        var object = AuthResponse.fromJson(res.data);
        SharedPref.setUserData(object.data?.user);
        SharedPref.setToken(object.data?.token);

        return object;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<AuthResponse?> login({required AuthParams params}) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.login,
        data: params.toJson(),
      );
      if (res.statusCode == 200) {
        var object = AuthResponse.fromJson(res.data);
        SharedPref.setUserData(object.data?.user);
        SharedPref.setToken(object.data?.token);

        return object;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> sendForgetPasswordLink({
    required AuthParams params,
  }) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.login,
        data: params.toJson(),
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }
}
