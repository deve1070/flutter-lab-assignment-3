import 'package:flutter_lab_assignment_3/domain/models/album.dart';

class AlbumViewModel {
  final List<Album> albums;
  final bool isLoading;
  final String? error;

  AlbumViewModel({
    required this.albums,
    this.isLoading = false,
    this.error,
  });

  factory AlbumViewModel.initial() => AlbumViewModel(albums: []);

  factory AlbumViewModel.loading() => AlbumViewModel(
        albums: [],
        isLoading: true,
      );

  factory AlbumViewModel.loaded(List<Album> albums) => AlbumViewModel(
        albums: albums,
        isLoading: false,
      );

  factory AlbumViewModel.error(String message) => AlbumViewModel(
        albums: [],
        isLoading: false,
        error: message,
      );

  AlbumViewModel copyWith({
    List<Album>? albums,
    bool? isLoading,
    String? error,
  }) {
    return AlbumViewModel(
      albums: albums ?? this.albums,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
} 