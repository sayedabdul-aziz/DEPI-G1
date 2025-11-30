import 'dart:developer';

import 'package:bookia/core/services/api/api_endpoints.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/domain/entities/auth_params.dart';
import 'package:bookia/features/auth/domain/entities/auth_response/data.dart';
import 'package:bookia/features/auth/domain/entities/auth_response/verify_email_response/verify_email_response.dart';
import 'package:dartz/dartz.dart';

abstract class AuthDataSource {
  Future<Either<Failure, AuthResponse>> register({required AuthParams params});
  Future<Either<Failure, AuthResponse>> login({required AuthParams params});
  Future<Either<Failure, VerifyEmailResponse>> verifyEmail();
}

class AuthRemoteDataSourceImpl implements AuthDataSource {
  @override
  Future<Either<Failure, AuthResponse>> login({
    required AuthParams params,
  }) async {
    var res = await DioProvider.postApi(
      endpoint: ApiEndpoints.login,
      data: params.toJson(),
    );

    return res.fold(
      (l) {
        return Left(ServerFailure(l.errorMessage));
      },
      (data) {
        AuthResponse authResponse = AuthResponse.fromJson(data);
        SharedPref.setUserData(authResponse.user);
        SharedPref.setToken(authResponse.token);

        return Right(data);
      },
    );
  }

  @override
  Future<Either<Failure, AuthResponse>> register({
    required AuthParams params,
  }) async {
    var res = await DioProvider.postApi(
      endpoint: ApiEndpoints.register,
      data: params.toJson(),
    );

    return res.fold(
      (l) {
        return Left(ServerFailure(l.errorMessage));
      },
      (data) {
        AuthResponse authResponse = AuthResponse.fromJson(data);
        SharedPref.setUserData(authResponse.user);
        SharedPref.setToken(authResponse.token);

        return Right(data);
      },
    );
  }

  @override
  Future<Either<Failure, VerifyEmailResponse>> verifyEmail() async {
    try {
      var res = await DioProvider.get(endpoint: 'resend-verify-code');
      var object = VerifyEmailResponse.fromJson(res.data);
      if (res.statusCode == 200) {
        return Right(object);
      } else {
        return Left(ServerFailure(object.message ?? ''));
      }
    } on Exception catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }
}
