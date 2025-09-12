import 'package:equatable/equatable.dart';
import 'package:shartflix_movie_app_case/features/auth/model/user_model.dart';

abstract class PhotoState extends Equatable {
  const PhotoState();

  @override
  List<Object?> get props => [];
}

class PhotoUploading extends PhotoState {}

class PhotoInitial extends PhotoState {}

class PhotoLoading extends PhotoState {}

class PhotoSuccess extends PhotoState {
  final UserModel user;
  const PhotoSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class PhotoError extends PhotoState {
  final String error;
  const PhotoError({required this.error});

  @override
  List<Object?> get props => [error];
}
