import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_lab_assignment_3/domain/models/album.dart';
import 'package:flutter_lab_assignment_3/presentation/bloc/album/album_cubit.dart';
import 'package:flutter_lab_assignment_3/presentation/bloc/album/album_state.dart';
import 'package:flutter_lab_assignment_3/presentation/widgets/error_view.dart';

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<AlbumCubit>().getAlbums();
            },
          ),
        ],
      ),
      body: BlocBuilder<AlbumCubit, AlbumState>(
        builder: (context, state) {
          if (state is AlbumInitial) {
            context.read<AlbumCubit>().getAlbums();
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading albums...'),
                ],
              ),
            );
          } else if (state is AlbumLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<AlbumCubit>().getAlbums();
              },
              child: _buildAlbumList(context, state.albums),
            );
          } else if (state is AlbumError) {
            return ErrorView(
              message: _getErrorMessage(state.message),
              onRetry: () {
                context.read<AlbumCubit>().getAlbums();
              },
              icon: _getErrorIcon(state.message),
              retryText: 'Try Again',
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  String _getErrorMessage(String error) {
    if (error.contains('SocketException') || error.contains('NetworkError')) {
      return 'Unable to connect to the server. Please check your internet connection.';
    } else if (error.contains('TimeoutException')) {
      return 'The request timed out. Please try again.';
    } else if (error.contains('404')) {
      return 'The requested resource was not found.';
    } else if (error.contains('500')) {
      return 'Server error occurred. Please try again later.';
    }
    return 'An error occurred: $error';
  }

  IconData _getErrorIcon(String error) {
    if (error.contains('SocketException') || error.contains('NetworkError')) {
      return Icons.wifi_off;
    } else if (error.contains('TimeoutException')) {
      return Icons.timer_off;
    } else if (error.contains('404')) {
      return Icons.error_outline;
    } else if (error.contains('500')) {
      return Icons.error_outline;
    }
    return Icons.error_outline;
  }

  Widget _buildAlbumList(BuildContext context, List<Album> albums) {
    if (albums.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_library_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'No albums found',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Pull down to refresh',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: albums.length,
      itemBuilder: (context, index) {
        final album = albums[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: InkWell(
            onTap: () {
              context.go('/album/${album.id}', extra: album);
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Hero(
                    tag: 'album_${album.id}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://picsum.photos/id/${album.id + 10}/150/150',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 32,
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[200],
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          album.title,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
} 