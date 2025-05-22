import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_lab_assignment_3/domain/models/album.dart';
import 'package:flutter_lab_assignment_3/domain/models/photo.dart';

class ApiService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';
  final http.Client _client;

  ApiService(this._client);

  Future<List<Album>> getAlbums() async {
    final response = await _client.get(Uri.parse('$baseUrl/albums'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Album.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  Future<Album> getAlbumById(int id) async {
    final response = await _client.get(Uri.parse('$baseUrl/albums/$id'));
    if (response.statusCode == 200) {
      return Album.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Photo>> getPhotos() async {
    final response = await _client.get(Uri.parse('$baseUrl/photos'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => _mapPhotoJson(json)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }

  Future<List<Photo>> getPhotosByAlbumId(int albumId) async {
    final response = await _client.get(Uri.parse('$baseUrl/albums/$albumId/photos'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => _mapPhotoJson(json)).toList();
    } else {
      throw Exception('Failed to load photos for album $albumId');
    }
  }

  Future<Photo> getPhotoById(int id) async {
    final response = await _client.get(Uri.parse('$baseUrl/photos/$id'));
    if (response.statusCode == 200) {
      return _mapPhotoJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load photo');
    }
  }

  Photo _mapPhotoJson(Map<String, dynamic> json) {
    // Use Picsum Photos for actual images
    final photoId = json['id'] as int;
    return Photo(
      id: photoId,
      albumId: json['albumId'] as int,
      title: json['title'] as String,
      url: 'https://picsum.photos/id/${photoId + 10}/800/800',
      thumbnailUrl: 'https://picsum.photos/id/${photoId + 10}/200/200',
    );
  }
} 