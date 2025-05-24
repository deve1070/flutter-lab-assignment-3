import 'package:flutter_lab_assignment_3/domain/models/photo.dart';

abstract class PhotoState {}

class PhotoInitial extends PhotoState {}

class PhotoLoading extends PhotoState {}

class PhotoLoaded extends PhotoState {
  final List<Photo> photos;

  PhotoLoaded(this.photos);
}

class PhotoError extends PhotoState {
  final String message;

  PhotoError(this.message);
} 