import 'dart:convert';
import 'dart:io';
import 'package:flutter_lab_assignment_3/domain/models/photo.dart';

abstract class PhotoRemoteDataSource {
  Future<List<Photo>> getPhotosByAlbumId(int albumId);
}

class PhotoRemoteDataSourceImpl implements PhotoRemoteDataSource {
  final HttpClient httpClient;
  final String baseUrl;

  PhotoRemoteDataSourceImpl({
    required this.httpClient,
    this.baseUrl = 'https://jsonplaceholder.typicode.com',
  });

  @override
  Future<List<Photo>> getPhotosByAlbumId(int albumId) async {
    try {
      final request = await httpClient.getUrl(
        Uri.parse('$baseUrl/photos?albumId=$albumId'),
      );
      final response = await request.close();
      
      if (response.statusCode == HttpStatus.ok) {
        final responseBody = await response.transform(utf8.decoder).join();
        final List<dynamic> jsonList = json.decode(responseBody);
        return jsonList.map((json) => Photo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load photos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load photos: $e');
    }
  }
} 