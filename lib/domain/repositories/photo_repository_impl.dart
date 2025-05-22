import 'package:flutter_lab_assignment_3/domain/models/photo.dart';
import 'package:flutter_lab_assignment_3/data/services/api_service.dart';
import 'package:flutter_lab_assignment_3/domain/repositories/photo_repository.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final ApiService _apiService;

  PhotoRepositoryImpl(this._apiService);

  @override
  Future<List<Photo>> getPhotos() async {
    return await _apiService.getPhotos();
  }

  @override
  Future<List<Photo>> getPhotosByAlbumId(int albumId) async {
    return await _apiService.getPhotosByAlbumId(albumId);
  }

  @override
  Future<Photo> getPhotoById(int id) async {
    return await _apiService.getPhotoById(id);
  }
} 