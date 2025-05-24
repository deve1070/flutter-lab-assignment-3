import 'package:flutter_lab_assignment_3/domain/models/photo.dart';
import 'package:flutter_lab_assignment_3/domain/repositories/photo_repository.dart';

class GetPhotosByAlbumIdUseCase {
  final PhotoRepository repository;

  GetPhotosByAlbumIdUseCase(this.repository);

  Future<List<Photo>> execute(int albumId) async {
    if (albumId <= 0) {
      throw Exception('Invalid album ID');
    }
    try {
      final photos = await repository.getPhotosByAlbumId(albumId);
      if (photos.isEmpty) {
        throw Exception('No photos found for album $albumId');
      }
      // Filter photos to ensure they match the album ID
      final albumPhotos = photos.where((photo) => photo.albumId == albumId).toList();
      if (albumPhotos.isEmpty) {
        throw Exception('No matching photos found for album $albumId');
      }
      // Sort photos by ID to ensure consistent ordering
      albumPhotos.sort((a, b) => a.id.compareTo(b.id));
      return albumPhotos;
    } catch (e) {
      throw Exception('Failed to fetch photos: $e');
    }
  }
} 