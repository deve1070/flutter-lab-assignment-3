import 'package:flutter_lab_assignment_3/data/cache/cache_manager.dart';
import 'package:flutter_lab_assignment_3/data/services/api_service.dart';
import 'package:flutter_lab_assignment_3/domain/models/photo.dart';
import 'package:flutter_lab_assignment_3/domain/repositories/photo_repository.dart';
import 'package:flutter_lab_assignment_3/core/error/error_handler.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final ApiService _apiService;
  final CacheManager _cacheManager;

  PhotoRepositoryImpl(this._apiService) : _cacheManager = CacheManager();

  @override
  Future<List<Photo>> getPhotos() async {
    try {
      final cachedPhotos = await _cacheManager.getCachedPhotos(0);
      if (cachedPhotos != null && cachedPhotos.isNotEmpty) {
        return cachedPhotos;
      }

      final photos = await _apiService.getPhotos();
      await _cacheManager.cachePhotos(0, photos);
      return photos;
    } catch (e) {
      final cachedPhotos = await _cacheManager.getCachedPhotos(0);
      if (cachedPhotos != null && cachedPhotos.isNotEmpty) {
        return cachedPhotos;
      }
      rethrow;
    }
  }

  @override
  Future<List<Photo>> getPhotosByAlbumId(int albumId) async {
    try {
      final cachedPhotos = await _cacheManager.getCachedPhotos(albumId);
      if (cachedPhotos != null && cachedPhotos.isNotEmpty) {
        return cachedPhotos;
      }

      final photos = await _apiService.getPhotosByAlbumId(albumId);
      
      if (photos.isNotEmpty) {
        await _cacheManager.cachePhotos(albumId, photos);
      }
      
      return photos;
    } catch (e) {
      final cachedPhotos = await _cacheManager.getCachedPhotos(albumId);
      if (cachedPhotos != null && cachedPhotos.isNotEmpty) {
        return cachedPhotos;
      }
      rethrow;
    }
  }

  @override
  Future<Photo> getPhotoById(int id) async {
    try {
      final photos = await _apiService.getPhotos();
      final photo = photos.firstWhere((p) => p.id == id);
      return photo;
    } catch (e) {
      rethrow;
    }
  }
} 