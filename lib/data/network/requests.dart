class LoginRequest {
  String email;
  String password;
  LoginRequest({
    required this.email,
    required this.password,
  });
}

class ForgetPassswordRequest {
  String email;

  ForgetPassswordRequest(
    this.email,
  );
}

class SignInRequest {
  String username;

  String mobileNumber;
  String email;
  String password;

  SignInRequest({
    required this.username,
    required this.mobileNumber,
    required this.email,
    required this.password,
  });
}
