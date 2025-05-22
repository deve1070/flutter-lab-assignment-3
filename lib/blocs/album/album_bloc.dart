import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_albums.dart';
import 'package:flutter_lab_assignment_3/blocs/album/album_event.dart';
import 'package:flutter_lab_assignment_3/blocs/album/album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final GetAlbums _getAlbums;

  AlbumBloc(this._getAlbums) : super(AlbumInitial()) {
    on<FetchAlbums>(_onFetchAlbums);
  }

  Future<void> _onFetchAlbums(FetchAlbums event, Emitter<AlbumState> emit) async {
    emit(AlbumLoading());
    try {
      final albums = await _getAlbums();
      emit(AlbumLoaded(albums));
    } catch (e) {
      emit(AlbumError(e.toString()));
    }
  }
} 