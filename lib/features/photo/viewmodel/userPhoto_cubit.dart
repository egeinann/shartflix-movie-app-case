import 'dart:io';
import 'package:bloc/bloc.dart';

import 'package:shartflix_movie_app_case/core/services/photo_service.dart';
import 'package:shartflix_movie_app_case/features/auth/model/user_model.dart';
import 'package:shartflix_movie_app_case/features/photo/viewmodel/userPhoto_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  final PhotoServices _photoServices;
  UserModel user;

  PhotoCubit(this._photoServices, this.user) : super(PhotoInitial());

  // *** FOTOĞRAF YÜKLE ***
  Future<void> uploadPhoto(File file) async {
    emit(PhotoLoading());
    final result = await _photoServices.uploadPhoto(file);

    if (result['success'] == true) {
      final updatedUserJson = result['user'];

      final updatedUser = user.copyWith(
        photoUrl: updatedUserJson['photoUrl'] ?? user.photoUrl,
      );

      user = updatedUser;
      emit(PhotoSuccess(user: updatedUser));
    } else {
      emit(PhotoError(error: result['error']));
    }
  }

  void removePhoto() {
    emit(PhotoSuccess(user: user.copyWith(photoUrl: "")));
  }
}
