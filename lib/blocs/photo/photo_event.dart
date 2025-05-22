abstract class PhotoEvent {}

class FetchPhotos extends PhotoEvent {}

class FetchPhotosByAlbumId extends PhotoEvent {
  final int albumId;

  FetchPhotosByAlbumId(this.albumId);
} 