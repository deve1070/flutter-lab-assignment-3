import 'dart:convert';
import 'package:flutter/foundation.dart';
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
    debugPrint('Fetching photos for album $albumId');
    final response = await _client.get(Uri.parse('$baseUrl/photos?albumId=$albumId'));
    debugPrint('Response status: ${response.statusCode}');
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      debugPrint('Received ${jsonList.length} photos for album $albumId');
      
      final photos = jsonList.map((json) {
        final photo = _mapPhotoJson(json);
        debugPrint('Mapped photo: id=${photo.id}, albumId=${photo.albumId}, url=${photo.url}');
        return photo;
      }).toList();
      
      return photos;
    } else {
      debugPrint('Error response: ${response.body}');
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
    final photo = Photo(
      id: json['id'] as int,
      albumId: json['albumId'] as int,
      title: json['title'] as String,
      url: 'https://picsum.photos/600/400?random=${json['id']}',
      thumbnailUrl: 'https://picsum.photos/150/150?random=${json['id']}',
    );
    debugPrint('Mapping photo: id=${photo.id}, albumId=${photo.albumId}, url=${photo.url}');
    return photo;
  }
} 