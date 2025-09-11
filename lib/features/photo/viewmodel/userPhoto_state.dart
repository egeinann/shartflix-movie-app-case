import 'dart:io';

abstract class PhotoState {}

class PhotoInitial extends PhotoState {}

class PhotoLoading extends PhotoState {}

class PhotoSuccess extends PhotoState {
  final Map<String, dynamic> user; // servisten gelen kullanıcı verisi
  final File? localFile;            // local olarak seçilen fotoğraf
  PhotoSuccess(this.user, {this.localFile});
}

class PhotoError extends PhotoState {
  final String message;
  PhotoError(this.message);
}