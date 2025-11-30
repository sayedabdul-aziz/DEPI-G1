import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:bookia/features/auth/data/repository/auth_repository_impl.dart';
import 'package:bookia/features/auth/domain/repository/auth_repository.dart';
import 'package:bookia/features/auth/domain/usecases/login_use_case.dart';
import 'package:bookia/features/auth/domain/usecases/register_use_case.dart';
import 'package:bookia/features/auth/domain/usecases/verify_email_use_case.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';

var gi = GetIt.instance;

Future<void> setupServiceLocator() async {
  await SharedPref.init();
  await DioProvider.init();

  // register services
  gi.registerSingleton(DioProvider());
  gi.registerSingleton(SharedPref());
  // register data sources
  gi.registerLazySingleton<AuthDataSource>(() => AuthRemoteDataSourceImpl());

  // register repositories
  gi.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: gi<AuthDataSource>()),
  );
  // register use cases
  gi.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(authRepository: gi<AuthRepository>()),
  );
  gi.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(authRepository: gi<AuthRepository>()),
  );
  gi.registerLazySingleton<VerifyEmailUseCase>(
    () => VerifyEmailUseCase(authRepository: gi<AuthRepository>()),
  );
  // register cubits
  gi.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      loginUseCase: gi<LoginUseCase>(),
      registerUseCase: gi<RegisterUseCase>(),
    ),
  );
}
