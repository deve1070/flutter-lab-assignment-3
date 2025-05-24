abstract class PhotoEvent {}

class GetPhotos extends PhotoEvent {}

class GetPhotosByAlbumId extends PhotoEvent {
  final int albumId;

  GetPhotosByAlbumId(this.albumId);
}

class GetPhotoById extends PhotoEvent {
  final int id;

  GetPhotoById(this.id);
} 