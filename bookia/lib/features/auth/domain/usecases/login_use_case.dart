import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/auth/domain/entities/auth_params.dart';
import 'package:bookia/features/auth/domain/entities/auth_response/data.dart';

import 'package:bookia/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<Either<Failure, AuthResponse>> call({required AuthParams params}) {
    return authRepository.login(params: params);
  }
}
