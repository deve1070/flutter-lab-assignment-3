import 'package:flutter_lab_assignment_3/domain/models/album.dart';
import 'package:flutter_lab_assignment_3/domain/repositories/album_repository.dart';

class GetAlbumsUseCase {
  final AlbumRepository _albumRepository;

  GetAlbumsUseCase(this._albumRepository);

  Future<List<Album>> execute() async {
    return await _albumRepository.getAlbums();
  }
} 