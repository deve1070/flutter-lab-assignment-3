import 'package:flutter_lab_assignment_3/domain/models/photo.dart';
import 'package:flutter_lab_assignment_3/domain/repositories/photo_repository.dart';

class GetPhotosByAlbumIdUseCase {
  final PhotoRepository _photoRepository;

  GetPhotosByAlbumIdUseCase(this._photoRepository);

  Future<List<Photo>> execute(int albumId) async {
    return await _photoRepository.getPhotosByAlbumId(albumId);
  }
} 