class UserRequest {
  String email;
  String password;
  String confirmPassword;

  UserRequest(
      {required this.email,
      required this.password,
      required this.confirmPassword});

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'confirmPassword': confirmPassword,
  };

  factory UserRequest.fromJson(Map<String, dynamic> json) => UserRequest(
    email: json['email'] as String,
    password: json['password'] as String,
    confirmPassword: json['confirmPassword'] as String,
  );
}
