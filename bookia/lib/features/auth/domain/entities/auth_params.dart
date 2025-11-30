class AuthParams {
  String? name;
  String? email;
  String? password;
  String? passwordConfirmation;

  AuthParams({this.name, this.email, this.password, this.passwordConfirmation});

  factory AuthParams.fromJson(Map<String, dynamic> json) {
    return AuthParams(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      passwordConfirmation: json['password_confirmation'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
    'password_confirmation': passwordConfirmation,
  };
}
