import 'dart:io';

enum AuthMode { SignUp, Login }

class AuthFormModel {
  String name = '';
  String email = '';
  String password = '';
  File? image;
  AuthMode _mode = AuthMode.Login;

  bool get isLogin => _mode == AuthMode.Login;

  bool get isSignUp => _mode == AuthMode.SignUp;

  void toggleAuthMode() => _mode = isLogin ? AuthMode.SignUp : AuthMode.Login;
}
