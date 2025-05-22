import 'package:flutter_lab_assignment_3/data/models/album.dart';
import 'package:flutter_lab_assignment_3/domain/repositories/album_repository.dart';

class GetAlbums {
  final AlbumRepository repository;

  GetAlbums(this.repository);

  Future<List<Album>> call() async {
    return await repository.getAlbums();
  }
} 