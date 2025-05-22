import 'package:flutter_lab_assignment_3/data/models/photo.dart';
import 'package:flutter_lab_assignment_3/domain/repositories/photo_repository.dart';

class GetPhotosByAlbumId {
  final PhotoRepository repository;

  GetPhotosByAlbumId(this.repository);

  Future<List<Photo>> call(int albumId) async {
    return await repository.getPhotosByAlbumId(albumId);
  }
} 