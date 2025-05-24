import 'package:flutter_lab_assignment_3/domain/models/photo.dart';
import 'package:flutter_lab_assignment_3/domain/repositories/photo_repository.dart';

class GetPhotosByAlbumIdUseCase {
  final PhotoRepository _photoRepository;

  GetPhotosByAlbumIdUseCase(this._photoRepository);

  Future<List<Photo>> execute(int albumId) async {
    if (albumId <= 0) {
      throw Exception('Invalid album ID');
    }
    try {
      final photos = await _photoRepository.getPhotosByAlbumId(albumId);
      if (photos.isEmpty) {
        throw Exception('No photos found for album $albumId');
      }
      return photos;
    } catch (e) {
      throw Exception('Failed to fetch photos: $e');
    }
  }
} 