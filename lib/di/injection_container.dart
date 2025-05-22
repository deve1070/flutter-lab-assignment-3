import 'dart:io';
import 'package:flutter_lab_assignment_3/data/datasources/album_remote_data_source.dart';
import 'package:flutter_lab_assignment_3/data/datasources/photo_remote_data_source.dart';
import 'package:flutter_lab_assignment_3/data/repositories/album_repository_impl.dart';
import 'package:flutter_lab_assignment_3/data/repositories/photo_repository_impl.dart';
import 'package:flutter_lab_assignment_3/domain/repositories/album_repository.dart';
import 'package:flutter_lab_assignment_3/domain/repositories/photo_repository.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_albums_usecase.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_photos_usecase.dart';
import 'package:flutter_lab_assignment_3/presentation/bloc/album/album_cubit.dart';
import 'package:flutter_lab_assignment_3/presentation/bloc/photo/photo_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => AlbumCubit(getAlbumsUseCase: sl()),
  );
  sl.registerFactory(
    () => PhotoCubit(getPhotosUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAlbumsUseCase(sl()));
  sl.registerLazySingleton(() => GetPhotosUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AlbumRepository>(
    () => AlbumRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<PhotoRepository>(
    () => PhotoRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AlbumRemoteDataSource>(
    () => AlbumRemoteDataSourceImpl(httpClient: sl()),
  );
  sl.registerLazySingleton<PhotoRemoteDataSource>(
    () => PhotoRemoteDataSourceImpl(httpClient: sl()),
  );

  // External
  sl.registerLazySingleton(() {
    final client = HttpClient();
    client.connectionTimeout = const Duration(seconds: 10);
    return client;
  });
} 