import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:bookia/features/auth/domain/entities/auth_params.dart';
import 'package:bookia/features/auth/domain/entities/auth_response/data.dart';
import 'package:bookia/features/auth/domain/entities/auth_response/verify_email_response/verify_email_response.dart';
import 'package:bookia/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});
  @override
  Future<Either<Failure, AuthResponse>> login({required AuthParams params}) {
    return authRemoteDataSource.login(params: params);
  }

  @override
  Future<Either<Failure, AuthResponse>> register({required AuthParams params}) {
    return authRemoteDataSource.register(params: params);
  }

  @override
  Future<Either<Failure, VerifyEmailResponse>> verifyEmail() {
    return authRemoteDataSource.verifyEmail();
  }
}
