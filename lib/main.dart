import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_lab_assignment_3/config/router.dart';
import 'package:flutter_lab_assignment_3/data/services/api_service.dart';
import 'package:flutter_lab_assignment_3/domain/repositories/album_repository_impl.dart';
import 'package:flutter_lab_assignment_3/domain/repositories/photo_repository_impl.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_albums_usecase.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_album_by_id_usecase.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_photos_usecase.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_photos_by_album_id_usecase.dart';
import 'package:flutter_lab_assignment_3/domain/usecases/get_photo_by_id_usecase.dart';
import 'package:flutter_lab_assignment_3/presentation/bloc/album/album_cubit.dart';
import 'package:flutter_lab_assignment_3/presentation/bloc/photo/photo_cubit.dart';
import 'package:flutter_lab_assignment_3/data/cache/cache_manager.dart';
import 'package:flutter_lab_assignment_3/core/error/error_handler.dart';
import 'package:flutter_lab_assignment_3/presentation/widgets/error_boundary.dart';
import 'package:flutter_lab_assignment_3/presentation/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize cache
  // await CacheManager.init();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final httpClient = http.Client();
  final apiService = ApiService(httpClient);
  
  final albumRepository = AlbumRepositoryImpl(apiService);
  final photoRepository = PhotoRepositoryImpl(apiService);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AlbumCubit(
          getAlbumsUseCase: GetAlbumsUseCase(albumRepository),
          getAlbumByIdUseCase: GetAlbumByIdUseCase(albumRepository),
        ),
      ),
      BlocProvider(
        create: (context) => PhotoCubit(
          getPhotosUseCase: GetPhotosUseCase(photoRepository),
          getPhotosByAlbumIdUseCase: GetPhotosByAlbumIdUseCase(photoRepository),
          getPhotoByIdUseCase: GetPhotoByIdUseCase(photoRepository),
        ),
      ),
    ],
    child: MaterialApp.router(
      title: 'Album Viewer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A237E),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A237E),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      routerConfig: AppRouter.router,
      builder: (context, child) {
        return ErrorBoundary(
          child: child!,
        );
      },
    ),
  ));
} 