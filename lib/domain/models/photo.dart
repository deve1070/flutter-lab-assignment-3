/// Represents a photo in the application.
/// This model is used to store photo data retrieved from the API.
class Photo {
  /// The unique identifier of the photo.
  final int id;

  /// The ID of the album this photo belongs to.
  final int albumId;

  /// The title of the photo.
  final String title;

  /// The URL of the full-size photo.
  final String url;

  /// The URL of the thumbnail version of the photo.
  final String thumbnailUrl;

  /// Creates a new [Photo] instance.
  Photo({
    required this.id,
    required this.albumId,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  /// Creates a [Photo] instance from a JSON map.
  /// 
  /// Throws [FormatException] if the JSON data is invalid.
  factory Photo.fromJson(Map<String, dynamic> json) {
    try {
      return Photo(
        id: json['id'] as int,
        albumId: json['albumId'] as int,
        title: json['title'] as String,
        url: json['url'] as String,
        thumbnailUrl: json['thumbnailUrl'] as String,
      );
    } catch (e) {
      throw FormatException('Invalid photo data: $e');
    }
  }

  /// Converts this [Photo] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'albumId': albumId,
      'title': title,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Photo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          albumId == other.albumId &&
          title == other.title &&
          url == other.url &&
          thumbnailUrl == other.thumbnailUrl;

  @override
  int get hashCode =>
      id.hashCode ^
      albumId.hashCode ^
      title.hashCode ^
      url.hashCode ^
      thumbnailUrl.hashCode;

  @override
  String toString() =>
      'Photo(id: $id, albumId: $albumId, title: $title, url: $url, thumbnailUrl: $thumbnailUrl)';
} 