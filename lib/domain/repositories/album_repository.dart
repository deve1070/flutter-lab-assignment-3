import '../models/album.dart';

abstract class AlbumRepository {
  Future<List<Album>> getAlbums();
  Future<Album> getAlbumById(int id);
} 