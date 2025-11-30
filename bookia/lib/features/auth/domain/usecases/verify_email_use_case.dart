import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/auth/domain/entities/auth_response/verify_email_response/verify_email_response.dart';
import 'package:bookia/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class VerifyEmailUseCase {
  final AuthRepository authRepository;
  VerifyEmailUseCase({required this.authRepository});
  Future<Either<Failure, VerifyEmailResponse>> call() {
    return authRepository.verifyEmail();
  }
}
