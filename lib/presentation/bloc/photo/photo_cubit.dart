import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_photos_usecase.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_photos_by_album_id_usecase.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_photo_by_id_usecase.dart';
import 'package:flutter_lab_assignment_3/presentation/bloc/photo/photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  final GetPhotosUseCase _getPhotosUseCase;
  final GetPhotosByAlbumIdUseCase _getPhotosByAlbumIdUseCase;
  final GetPhotoByIdUseCase _getPhotoByIdUseCase;

  PhotoCubit({
    required GetPhotosUseCase getPhotosUseCase,
    required GetPhotosByAlbumIdUseCase getPhotosByAlbumIdUseCase,
    required GetPhotoByIdUseCase getPhotoByIdUseCase,
  })  : _getPhotosUseCase = getPhotosUseCase,
        _getPhotosByAlbumIdUseCase = getPhotosByAlbumIdUseCase,
        _getPhotoByIdUseCase = getPhotoByIdUseCase,
        super(PhotoInitial());

  Future<void> getPhotos() async {
    emit(PhotoLoading());
    try {
      final photos = await _getPhotosUseCase.execute();
      emit(PhotoLoaded(photos));
    } catch (e) {
      debugPrint('Error in getPhotos: $e');
      emit(PhotoError(e.toString()));
    }
  }

  Future<void> getPhotosByAlbumId(int albumId) async {
    debugPrint('Getting photos for album $albumId');
    emit(PhotoLoading());
    try {
      final photos = await _getPhotosByAlbumIdUseCase.execute(albumId);
      debugPrint('Received ${photos.length} photos for album $albumId');
      
      if (photos.isEmpty) {
        debugPrint('No photos found for album $albumId');
        emit(PhotoError('No photos found for album $albumId'));
      } else {
        // Filter photos to ensure they match the album ID
        final albumPhotos = photos.where((photo) => photo.albumId == albumId).toList();
        if (albumPhotos.isEmpty) {
          debugPrint('No matching photos found for album $albumId');
          emit(PhotoError('No matching photos found for album $albumId'));
        } else {
          debugPrint('Found ${albumPhotos.length} matching photos for album $albumId');
          // Sort photos by ID to ensure consistent ordering
          albumPhotos.sort((a, b) => a.id.compareTo(b.id));
          emit(PhotoLoaded(albumPhotos));
        }
      }
    } catch (e) {
      debugPrint('Error in getPhotosByAlbumId: $e');
      emit(PhotoError(e.toString()));
    }
  }

  Future<void> getPhotoById(int id) async {
    emit(PhotoLoading());
    try {
      final photo = await _getPhotoByIdUseCase.execute(id);
      emit(PhotoLoaded([photo]));
    } catch (e) {
      debugPrint('Error in getPhotoById: $e');
      emit(PhotoError(e.toString()));
    }
  }
} 