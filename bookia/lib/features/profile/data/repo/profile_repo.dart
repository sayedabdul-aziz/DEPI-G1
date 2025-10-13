import 'package:bookia/core/services/api/api_endpoints.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/profile/data/models/edit_profile_params.dart';
import 'package:bookia/features/profile/data/models/profile_response/profile_response.dart';

class ProfileRepo {
  static Future<bool> logout() async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.logout,
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );

      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<ProfileResponse?> updateProfile(
    EditProfileParams params,
  ) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.updateProfile,
        data: params.toFormData(),
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );

      if (res.statusCode == 200) {
        var data = ProfileResponse.fromJson(res.data);
        SharedPref.setUserData(data.data);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
