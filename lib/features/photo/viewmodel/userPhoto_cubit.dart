import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:shartflix_movie_app_case/core/services/photo_service.dart';
import 'package:shartflix_movie_app_case/features/auth/model/user_model.dart';
import 'package:shartflix_movie_app_case/features/auth/viewmodel/auth_cubit.dart';
import 'package:shartflix_movie_app_case/features/photo/viewmodel/userPhoto_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  PhotoCubit() : super(PhotoInitial());

  File? _localFile;

  Future<void> uploadPhoto(
    File file,
    String password, {
    AuthCubit? authCubit,
  }) async {
    _localFile = file;
    emit(PhotoLoading());

    final result = await PhotoServices().uploadPhoto(file);
    if (result['success']) {
      final userMap = result['user'] as Map<String, dynamic>;
      emit(PhotoSuccess(userMap, localFile: _localFile));

      // AuthCubit var ise foto URL'sini oraya da yolla
      if (authCubit != null) {
        final photoUrl = userMap['photoUrl'] as String?;
        authCubit.updatePhotoUrl(photoUrl);
      }
    } else {
      emit(PhotoError(result['error'] ?? 'Bilinmeyen hata'));
    }
  }

  void skip(String password) {
    _localFile = null;
    final userMap = {
      'id': '',
      'name': '',
      'email': '',
      'password': password,
      'photoUrl': null,
    };
    emit(PhotoSuccess(userMap, localFile: null));
  }

  void removeLocalPhoto() {
    _localFile = null;
    if (state is PhotoSuccess) {
      final user = (state as PhotoSuccess).user;
      emit(PhotoSuccess(user, localFile: null));
    }
  }
}
