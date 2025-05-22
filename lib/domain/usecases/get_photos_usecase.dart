import 'package:flutter_lab_assignment_3/domain/models/photo.dart';
import 'package:flutter_lab_assignment_3/domain/repositories/photo_repository.dart';

class GetPhotosUseCase {
  final PhotoRepository _photoRepository;

  GetPhotosUseCase(this._photoRepository);

  Future<List<Photo>> execute() async {
    return await _photoRepository.getPhotos();
  }
} 