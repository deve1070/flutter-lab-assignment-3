import 'package:flutter_lab_assignment_3/data/cache/cache_manager.dart';
import 'package:flutter_lab_assignment_3/data/services/api_service.dart';
import 'package:flutter_lab_assignment_3/domain/models/photo.dart';
import 'package:flutter_lab_assignment_3/domain/repositories/photo_repository.dart';
import 'package:flutter_lab_assignment_3/core/error/error_handler.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final ApiService _apiService;

  PhotoRepositoryImpl(this._apiService);

  @override
  Future<List<Photo>> getPhotos(int albumId) async {
    try {
      // Check cache first
      if (await CacheManager.isCacheValid()) {
        final cachedPhotos = CacheManager.getCachedPhotos();
        if (cachedPhotos != null && cachedPhotos.isNotEmpty) {
          return cachedPhotos.where((photo) => photo.albumId == albumId).toList();
        }
      }

      // If cache is invalid or empty, fetch from API
      final photos = await _apiService.getPhotos(albumId);
      
      // Cache the results
      await CacheManager.cachePhotos(photos);
      
      return photos;
    } catch (e) {
      // If API call fails, try to return cached data
      final cachedPhotos = CacheManager.getCachedPhotos();
      if (cachedPhotos != null && cachedPhotos.isNotEmpty) {
        return cachedPhotos.where((photo) => photo.albumId == albumId).toList();
      }
      
      // If no cached data, throw the error
      throw await ErrorHandler.handleError(e);
    }
  }
} 