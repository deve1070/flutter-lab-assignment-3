import 'package:flutter_lab_assignment_3/data/cache/cache_manager.dart';
import 'package:flutter_lab_assignment_3/data/services/api_service.dart';
import 'package:flutter_lab_assignment_3/domain/models/album.dart';
import 'package:flutter_lab_assignment_3/domain/repositories/album_repository.dart';
import 'package:flutter_lab_assignment_3/core/error/error_handler.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final ApiService _apiService;

  AlbumRepositoryImpl(this._apiService);

  @override
  Future<List<Album>> getAlbums() async {
    try {
      // Check cache first
      if (await CacheManager.isCacheValid()) {
        final cachedAlbums = CacheManager.getCachedAlbums();
        if (cachedAlbums.isNotEmpty) {
          return cachedAlbums;
        }
      }

      // If cache is invalid or empty, fetch from API
      final albums = await _apiService.getAlbums();
      
      // Cache the results
      await CacheManager.cacheAlbums(albums);
      
      return albums;
    } catch (e) {
      // If API call fails, try to return cached data
      final cachedAlbums = CacheManager.getCachedAlbums();
      if (cachedAlbums.isNotEmpty) {
        return cachedAlbums;
      }
      
      // If no cached data, throw the error
      throw ErrorHandler.handleError(e);
    }
  }
} 