import 'package:flutter_lab_assignment_3/domain/models/album.dart';
import 'package:flutter_lab_assignment_3/data/services/api_service.dart';
import 'package:flutter_lab_assignment_3/domain/repositories/album_repository.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final ApiService _apiService;

  AlbumRepositoryImpl(this._apiService);

  @override
  Future<List<Album>> getAlbums() async {
    return await _apiService.getAlbums();
  }

  @override
  Future<Album> getAlbumById(int id) async {
    return await _apiService.getAlbumById(id);
  }
} 