import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_albums_usecase.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_album_by_id_usecase.dart';
import 'package:flutter_lab_assignment_3/presentation/bloc/album/album_state.dart';

class AlbumCubit extends Cubit<AlbumState> {
  final GetAlbumsUseCase _getAlbumsUseCase;
  final GetAlbumByIdUseCase _getAlbumByIdUseCase;

  AlbumCubit({
    required GetAlbumsUseCase getAlbumsUseCase,
    required GetAlbumByIdUseCase getAlbumByIdUseCase,
  })  : _getAlbumsUseCase = getAlbumsUseCase,
        _getAlbumByIdUseCase = getAlbumByIdUseCase,
        super(AlbumInitial());

  Future<void> getAlbums() async {
    emit(AlbumLoading());
    try {
      final albums = await _getAlbumsUseCase.execute();
      emit(AlbumLoaded(albums));
    } catch (e) {
      emit(AlbumError(e.toString()));
    }
  }

  Future<void> getAlbumById(int id) async {
    emit(AlbumLoading());
    try {
      final album = await _getAlbumByIdUseCase.execute(id);
      emit(AlbumLoaded([album]));
    } catch (e) {
      emit(AlbumError(e.toString()));
    }
  }
} 