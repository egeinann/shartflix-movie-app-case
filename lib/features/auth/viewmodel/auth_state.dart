import 'package:shartflix_movie_app_case/features/auth/model/user_model.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final UserModel? user;
  final String email;
  final String password;
  final String name;
  final bool isSuccess;

  // Yeni alanlar
  final bool emailError;
  final bool passwordError;

  AuthState({
    this.isLoading = false,
    this.error,
    this.user,
    this.email = '',
    this.password = '',
    this.name = '',
    this.isSuccess = false,
    this.emailError = false,
    this.passwordError = false,
  });

  AuthState copyWith({
    bool? isLoading,
    String? error,
    UserModel? user,
    String? email,
    String? password,
    String? name,
    bool? isSuccess,
    bool? emailError,
    bool? passwordError,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      user: user ?? this.user,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      isSuccess: isSuccess ?? this.isSuccess,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
    );
  }
}