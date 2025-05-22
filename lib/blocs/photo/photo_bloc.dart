import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_photos.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_photos_by_album_id.dart';
import 'package:flutter_lab_assignment_3/blocs/photo/photo_event.dart';
import 'package:flutter_lab_assignment_3/blocs/photo/photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final GetPhotos _getPhotos;
  final GetPhotosByAlbumId _getPhotosByAlbumId;

  PhotoBloc(this._getPhotos, this._getPhotosByAlbumId) : super(PhotoInitial()) {
    on<FetchPhotos>(_onFetchPhotos);
    on<FetchPhotosByAlbumId>(_onFetchPhotosByAlbumId);
  }

  Future<void> _onFetchPhotos(FetchPhotos event, Emitter<PhotoState> emit) async {
    emit(PhotoLoading());
    try {
      final photos = await _getPhotos();
      emit(PhotoLoaded(photos));
    } catch (e) {
      emit(PhotoError(e.toString()));
    }
  }

  Future<void> _onFetchPhotosByAlbumId(
      FetchPhotosByAlbumId event, Emitter<PhotoState> emit) async {
    emit(PhotoLoading());
    try {
      final photos = await _getPhotosByAlbumId(event.albumId);
      emit(PhotoLoaded(photos));
    } catch (e) {
      emit(PhotoError(e.toString()));
    }
  }
} 