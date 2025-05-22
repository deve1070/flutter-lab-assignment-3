import 'package:flutter_lab_assignment_3/domain/models/photo.dart';
import 'package:flutter_lab_assignment_3/domain/repositories/photo_repository.dart';

class GetPhotoByIdUseCase {
  final PhotoRepository _photoRepository;

  GetPhotoByIdUseCase(this._photoRepository);

  Future<Photo> execute(int id) async {
    return await _photoRepository.getPhotoById(id);
  }
} 