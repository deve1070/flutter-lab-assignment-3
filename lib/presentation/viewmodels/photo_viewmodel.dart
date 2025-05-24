import 'package:flutter_lab_assignment_3/domain/models/photo.dart';

class PhotoViewModel {
  final List<Photo> photos;
  final bool isLoading;
  final String? error;

  PhotoViewModel({
    required this.photos,
    this.isLoading = false,
    this.error,
  });

  factory PhotoViewModel.initial() => PhotoViewModel(photos: []);

  factory PhotoViewModel.loading() => PhotoViewModel(
        photos: [],
        isLoading: true,
      );

  factory PhotoViewModel.loaded(List<Photo> photos) => PhotoViewModel(
        photos: photos,
        isLoading: false,
      );

  factory PhotoViewModel.error(String message) => PhotoViewModel(
        photos: [],
        isLoading: false,
        error: message,
      );

  PhotoViewModel copyWith({
    List<Photo>? photos,
    bool? isLoading,
    String? error,
  }) {
    return PhotoViewModel(
      photos: photos ?? this.photos,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
} 