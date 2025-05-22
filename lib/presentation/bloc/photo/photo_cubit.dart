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
      emit(PhotoError(e.toString()));
    }
  }

  Future<void> getPhotosByAlbumId(int albumId) async {
    emit(PhotoLoading());
    try {
      final photos = await _getPhotosByAlbumIdUseCase.execute(albumId);
      emit(PhotoLoaded(photos));
    } catch (e) {
      emit(PhotoError(e.toString()));
    }
  }

  Future<void> getPhotoById(int id) async {
    emit(PhotoLoading());
    try {
      final photo = await _getPhotoByIdUseCase.execute(id);
      emit(PhotoLoaded([photo]));
    } catch (e) {
      emit(PhotoError(e.toString()));
    }
  }
} 