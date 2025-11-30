import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/auth/domain/entities/auth_params.dart';
import 'package:bookia/features/auth/domain/entities/auth_response/data.dart';

import 'package:bookia/features/auth/domain/entities/auth_response/verify_email_response/verify_email_response.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> register({required AuthParams params});
  Future<Either<Failure, AuthResponse>> login({required AuthParams params});
  Future<Either<Failure, VerifyEmailResponse>> verifyEmail();
}
