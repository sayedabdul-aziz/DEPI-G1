import 'dart:developer';

import 'package:bookia/core/services/api/api_endpoints.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/wishlist/data/models/wishlist_response/wishlist_response.dart';

class WishlistRepo {
  static Future<WishlistResponse?> getWishlist() async {
    try {
      var res = await DioProvider.get(
        endpoint: ApiEndpoints.wishlist,
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );

      if (res.statusCode == 200) {
        var data = WishlistResponse.fromJson(res.data);
        SharedPref.saveWishlist(data.data?.data);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<WishlistResponse?> removeFromWishlist({
    required int productId,
  }) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.removeFromWishlist,
        data: {"product_id": productId},
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );

      if (res.statusCode == 200) {
        var data = WishlistResponse.fromJson(res.data);
        SharedPref.saveWishlist(data.data?.data);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<WishlistResponse?> addToWishlist({
    required int productId,
  }) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.addToWishlist,
        data: {"product_id": productId},
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );

      if (res.statusCode == 200) {
        var data = WishlistResponse.fromJson(res.data);
        SharedPref.saveWishlist(data.data?.data);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
