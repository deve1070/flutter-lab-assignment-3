import 'dart:convert';
import 'dart:io';
import 'package:flutter_lab_assignment_3/domain/models/album.dart';

abstract class AlbumRemoteDataSource {
  Future<List<Album>> getAlbums();
}

class AlbumRemoteDataSourceImpl implements AlbumRemoteDataSource {
  final HttpClient httpClient;
  final String baseUrl;

  AlbumRemoteDataSourceImpl({
    required this.httpClient,
    this.baseUrl = 'https://jsonplaceholder.typicode.com',
  });

  @override
  Future<List<Album>> getAlbums() async {
    try {
      final request = await httpClient.getUrl(Uri.parse('$baseUrl/albums'));
      final response = await request.close();
      
      if (response.statusCode == HttpStatus.ok) {
        final responseBody = await response.transform(utf8.decoder).join();
        final List<dynamic> jsonList = json.decode(responseBody);
        return jsonList.map((json) => Album.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load albums: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load albums: $e');
    }
  }
} 