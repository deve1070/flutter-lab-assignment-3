import 'dart:io';
import 'package:flutter_lab_assignment_3/data/datasources/album_remote_data_source.dart';
import 'package:flutter_lab_assignment_3/data/datasources/photo_remote_data_source.dart';
import 'package:flutter_lab_assignment_3/data/repositories/album_repository_impl.dart';
import 'package:flutter_lab_assignment_3/data/repositories/photo_repository_impl.dart';
import 'package:flutter_lab_assignment_3/domain/repositories/album_repository.dart';
import 'package:flutter_lab_assignment_3/domain/repositories/photo_repository.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_albums_usecase.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_album_by_id_usecase.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_photos_usecase.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_photos_by_album_id_usecase.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_photo_by_id_usecase.dart';
import 'package:flutter_lab_assignment_3/blocs/album/album_bloc.dart';
import 'package:flutter_lab_assignment_3/blocs/photo/photo_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_lab_assignment_3/data/services/api_service.dart';

final getIt = GetIt.instance;

void init() {
  // Services
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt()));

  // Repositories
  getIt.registerLazySingleton<AlbumRepositoryImpl>(
    () => AlbumRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<PhotoRepositoryImpl>(
    () => PhotoRepositoryImpl(getIt()),
  );

  // Use cases
  getIt.registerLazySingleton<GetAlbumsUseCase>(
    () => GetAlbumsUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetAlbumByIdUseCase>(
    () => GetAlbumByIdUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetPhotosUseCase>(
    () => GetPhotosUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetPhotosByAlbumIdUseCase>(
    () => GetPhotosByAlbumIdUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetPhotoByIdUseCase>(
    () => GetPhotoByIdUseCase(getIt()),
  );

  // BLoCs
  getIt.registerFactory<AlbumBloc>(
    () => AlbumBloc(
      getAlbumsUseCase: getIt(),
      getAlbumByIdUseCase: getIt(),
    ),
  );
  getIt.registerFactory<PhotoBloc>(
    () => PhotoBloc(
      getPhotosUseCase: getIt(),
      getPhotosByAlbumIdUseCase: getIt(),
      getPhotoByIdUseCase: getIt(),
    ),
  );

  // Data sources
  getIt.registerLazySingleton<AlbumRemoteDataSource>(
    () => AlbumRemoteDataSourceImpl(httpClient: getIt()),
  );
  getIt.registerLazySingleton<PhotoRemoteDataSource>(
    () => PhotoRemoteDataSourceImpl(httpClient: getIt()),
  );

  // External
  getIt.registerLazySingleton(() {
    final client = HttpClient();
    client.connectionTimeout = const Duration(seconds: 10);
    return client;
  });
} 