import 'package:flutter_lab_assignment_3/domain/models/album.dart';
import 'package:flutter_lab_assignment_3/domain/repositories/album_repository.dart';

class GetAlbumByIdUseCase {
  final AlbumRepository _albumRepository;

  GetAlbumByIdUseCase(this._albumRepository);

  Future<Album> execute(int id) async {
    return await _albumRepository.getAlbumById(id);
  }
} 