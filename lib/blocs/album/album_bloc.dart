import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_albums_usecase.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_album_by_id_usecase.dart';
import 'package:flutter_lab_assignment_3/blocs/album/album_event.dart';
import 'package:flutter_lab_assignment_3/blocs/album/album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final GetAlbumsUseCase _getAlbumsUseCase;
  final GetAlbumByIdUseCase _getAlbumByIdUseCase;

  AlbumBloc({
    required GetAlbumsUseCase getAlbumsUseCase,
    required GetAlbumByIdUseCase getAlbumByIdUseCase,
  })  : _getAlbumsUseCase = getAlbumsUseCase,
        _getAlbumByIdUseCase = getAlbumByIdUseCase,
        super(AlbumInitial()) {
    on<GetAlbums>(_onGetAlbums);
    on<GetAlbumById>(_onGetAlbumById);
  }

  Future<void> _onGetAlbums(GetAlbums event, Emitter<AlbumState> emit) async {
    emit(AlbumLoading());
    try {
      final albums = await _getAlbumsUseCase.execute();
      emit(AlbumLoaded(albums));
    } catch (e) {
      debugPrint('Error in getAlbums: $e');
      emit(AlbumError(e.toString()));
    }
  }

  Future<void> _onGetAlbumById(GetAlbumById event, Emitter<AlbumState> emit) async {
    emit(AlbumLoading());
    try {
      final album = await _getAlbumByIdUseCase.execute(event.id);
      emit(AlbumLoaded([album]));
    } catch (e) {
      debugPrint('Error in getAlbumById: $e');
      emit(AlbumError(e.toString()));
    }
  }
} 