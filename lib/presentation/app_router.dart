import 'package:go_router/go_router.dart';
import 'package:flutter_lab_assignment_3/domain/models/album.dart';
import 'package:flutter_lab_assignment_3/presentation/screens/album_list_screen.dart';
import 'package:flutter_lab_assignment_3/presentation/screens/album_detail_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const AlbumListScreen(),
      ),
      GoRoute(
        path: '/album/:id',
        builder: (context, state) {
          final albumId = int.parse(state.pathParameters['id']!);
          final album = state.extra as Album?;
          return AlbumDetailScreen(
            albumId: albumId,
            album: album,
          );
        },
      ),
    ],
  );
} 