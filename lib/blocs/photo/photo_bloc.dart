import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_photos_usecase.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_photos_by_album_id_usecase.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_photo_by_id_usecase.dart';
import 'package:flutter_lab_assignment_3/blocs/photo/photo_event.dart';
import 'package:flutter_lab_assignment_3/blocs/photo/photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final GetPhotosUseCase _getPhotosUseCase;
  final GetPhotosByAlbumIdUseCase _getPhotosByAlbumIdUseCase;
  final GetPhotoByIdUseCase _getPhotoByIdUseCase;

  PhotoBloc({
    required GetPhotosUseCase getPhotosUseCase,
    required GetPhotosByAlbumIdUseCase getPhotosByAlbumIdUseCase,
    required GetPhotoByIdUseCase getPhotoByIdUseCase,
  })  : _getPhotosUseCase = getPhotosUseCase,
        _getPhotosByAlbumIdUseCase = getPhotosByAlbumIdUseCase,
        _getPhotoByIdUseCase = getPhotoByIdUseCase,
        super(PhotoInitial()) {
    on<GetPhotos>(_onGetPhotos);
    on<GetPhotosByAlbumId>(_onGetPhotosByAlbumId);
    on<GetPhotoById>(_onGetPhotoById);
  }

  Future<void> _onGetPhotos(GetPhotos event, Emitter<PhotoState> emit) async {
    emit(PhotoLoading());
    try {
      final photos = await _getPhotosUseCase.execute();
      emit(PhotoLoaded(photos));
    } catch (e) {
      debugPrint('Error in getPhotos: $e');
      emit(PhotoError(e.toString()));
    }
  }

  Future<void> _onGetPhotosByAlbumId(GetPhotosByAlbumId event, Emitter<PhotoState> emit) async {
    debugPrint('Getting photos for album ${event.albumId}');
    emit(PhotoLoading());
    try {
      final photos = await _getPhotosByAlbumIdUseCase.execute(event.albumId);
      debugPrint('Received ${photos.length} photos for album ${event.albumId}');
      
      if (photos.isEmpty) {
        debugPrint('No photos found for album ${event.albumId}');
        emit(PhotoError('No photos found for album ${event.albumId}'));
      } else {
        // Filter photos to ensure they match the album ID
        final albumPhotos = photos.where((photo) => photo.albumId == event.albumId).toList();
        if (albumPhotos.isEmpty) {
          debugPrint('No matching photos found for album ${event.albumId}');
          emit(PhotoError('No matching photos found for album ${event.albumId}'));
        } else {
          debugPrint('Found ${albumPhotos.length} matching photos for album ${event.albumId}');
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

  Future<void> _onGetPhotoById(GetPhotoById event, Emitter<PhotoState> emit) async {
    emit(PhotoLoading());
    try {
      final photo = await _getPhotoByIdUseCase.execute(event.id);
      emit(PhotoLoaded([photo]));
    } catch (e) {
      debugPrint('Error in getPhotoById: $e');
      emit(PhotoError(e.toString()));
    }
  }
} 