import 'package:flutter_lab_assignment_3/domain/models/album.dart';
import 'package:flutter_lab_assignment_3/domain/models/photo.dart';

class CacheManager {
  static final CacheManager _instance = CacheManager._internal();
  factory CacheManager() => _instance;
  CacheManager._internal();

  final Map<String, List<Album>> _albumsCache = {};
  final Map<String, List<Photo>> _photosCache = {};
  DateTime? _lastAlbumsFetch;
  DateTime? _lastPhotosFetch;
  static const Duration _cacheDuration = Duration(minutes: 5);

  Future<void> cacheAlbums(List<Album> albums) async {
    _albumsCache['all'] = albums;
    _lastAlbumsFetch = DateTime.now();
  }

  Future<void> cachePhotos(int albumId, List<Photo> photos) async {
    _photosCache[albumId.toString()] = photos;
    _lastPhotosFetch = DateTime.now();
  }

  Future<List<Album>?> getCachedAlbums() async {
    if (_lastAlbumsFetch == null) return null;
    if (DateTime.now().difference(_lastAlbumsFetch!) > _cacheDuration) {
      _albumsCache.clear();
      _lastAlbumsFetch = null;
      return null;
    }
    return _albumsCache['all'];
  }

  Future<List<Photo>?> getCachedPhotos(int albumId) async {
    if (_lastPhotosFetch == null) return null;
    if (DateTime.now().difference(_lastPhotosFetch!) > _cacheDuration) {
      _photosCache.clear();
      _lastPhotosFetch = null;
      return null;
    }
    return _photosCache[albumId.toString()];
  }

  Future<void> clearCache() async {
    _albumsCache.clear();
    _photosCache.clear();
    _lastAlbumsFetch = null;
    _lastPhotosFetch = null;
  }
} 