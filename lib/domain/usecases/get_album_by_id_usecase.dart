import 'package:flutter_lab_assignment_3/domain/models/album.dart';
import 'package:flutter_lab_assignment_3/domain/repositories/album_repository.dart';

class GetAlbumByIdUseCase {
  final AlbumRepository repository;

  GetAlbumByIdUseCase(this.repository);

  Future<Album> execute(int id) async {
    return await repository.getAlbumById(id);
  }
} 