import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/auth/domain/entities/auth_params.dart';
import 'package:bookia/features/auth/domain/entities/auth_response/data.dart';

import 'package:bookia/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase {
  final AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});

  Future<Either<Failure, AuthResponse>> call({required AuthParams params}) {
    return authRepository.register(params: params);
  }
}
