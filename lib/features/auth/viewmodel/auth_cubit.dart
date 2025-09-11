import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shartflix_movie_app_case/core/services/auth_service.dart';

import 'package:shartflix_movie_app_case/features/auth/model/user_model.dart';
import 'package:shartflix_movie_app_case/features/auth/viewmodel/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthServices _authServices;
  AuthCubit(this._authServices) : super(AuthState());

  void emailChanged(String email) => emit(state.copyWith(email: email));
  void passwordChanged(String password) =>
      emit(state.copyWith(password: password));
  void nameChanged(String name) => emit(state.copyWith(name: name));
  
  void updatePhotoUrl(String? photoUrl) {
    if (state.user != null) {
      emit(state.copyWith(user: state.user!.copyWith(photoUrl: photoUrl)));
    }
  }

  Future<void> login() async {
    validateFields();

    if (!canSubmit()) return; // Field error varsa API çağrısını yapma

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final result = await _authServices.login(state.email, state.password);
      if (result['success']) {
        final data = result['user'];
        final user = UserModel.fromJson(data, state.password);
        emit(state.copyWith(user: user, isLoading: false));
      } else {
        emit(state.copyWith(isLoading: false, error: result['error']));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> register() async {
    final emailError = state.email.isEmpty || !state.email.contains('@');
    final passwordError = state.password.isEmpty || state.password.length < 6;
    final nameError = state.name.isEmpty;

    emit(
      state.copyWith(
        emailError: emailError,
        passwordError: passwordError,
        isLoading: false,
      ),
    );

    if (emailError || passwordError || nameError) return;

    emit(state.copyWith(isLoading: true, error: null, isSuccess: false));

    try {
      final result = await _authServices.register(
        state.name,
        state.email,
        state.password,
        state.user?.photoUrl, // Fotoğraf URL’i burada gönderiliyor
      );

      if (result['success'] == true) {
        final userData = result['user'];
        emit(
          state.copyWith(
            user: UserModel.fromJson(userData, state.password),
            isLoading: false,
            isSuccess: true,
          ),
        );
        debugPrint("Kayıt başarılı");
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            error: result['error'] ?? 'Kayıt işlemi başarısız oldu',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Sunucuya bağlanılamadı: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> fetchProfile() async {
    emit(state.copyWith(isSuccess: false, isLoading: true, error: null));
    try {
      final result = await _authServices.getProfile();
      if (result['success']) {
        final data = result['user'];
        final user = UserModel.fromJson(data, '');
        emit(state.copyWith(user: user, isLoading: false));
      } else {
        emit(
          state.copyWith(
            isSuccess: true,
            isLoading: false,
            error: result['error'],
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void validateFields() {
    bool eError = state.email.isEmpty;
    bool pError = state.password.isEmpty;

    emit(state.copyWith(emailError: eError, passwordError: pError));
  }

  bool canSubmit() {
    return !state.emailError && !state.passwordError;
  }

  bool validateInputs({
    required String name,
    required String email,
    required String password,
    required String retryPassword,
  }) {
    bool valid = true;

    if (!email.contains('@')) {
      emit(state.copyWith(emailError: true));
      valid = false;
    }

    if (password.length < 6) {
      emit(state.copyWith(passwordError: true));
      valid = false;
    }

    if (password != retryPassword) {
      emit(state.copyWith(passwordError: true));
      valid = false;
    }

    return valid;
  }
}
