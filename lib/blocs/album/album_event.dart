abstract class AlbumEvent {}

class GetAlbums extends AlbumEvent {}

class GetAlbumById extends AlbumEvent {
  final int id;

  GetAlbumById(this.id);
} 