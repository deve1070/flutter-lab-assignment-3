import '../models/photo.dart';

abstract class PhotoRepository {
  Future<List<Photo>> getPhotos();
  Future<List<Photo>> getPhotosByAlbumId(int albumId);
  Future<Photo> getPhotoById(int id);
} 