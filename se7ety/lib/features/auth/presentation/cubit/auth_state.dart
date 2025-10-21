class AuthState {}

class AuthInitialSate extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthErrorState extends AuthState {
  String message;
  AuthErrorState({required this.message});
}
