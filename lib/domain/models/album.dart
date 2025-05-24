/// Represents an album in the application.
/// This model is used to store album data retrieved from the API.
class Album {
  /// The unique identifier of the album.
  final int id;

  /// The ID of the user who owns the album.
  final int userId;

  /// The title of the album.
  final String title;

  /// Creates a new [Album] instance.
  Album({
    required this.id,
    required this.userId,
    required this.title,
  });

  /// Creates an [Album] instance from a JSON map.
  /// 
  /// Throws [FormatException] if the JSON data is invalid.
  factory Album.fromJson(Map<String, dynamic> json) {
    try {
      return Album(
        id: json['id'] as int,
        userId: json['userId'] as int,
        title: json['title'] as String,
      );
    } catch (e) {
      throw FormatException('Invalid album data: $e');
    }
  }

  /// Converts this [Album] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Album &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          title == other.title;

  @override
  int get hashCode => id.hashCode ^ userId.hashCode ^ title.hashCode;

  @override
  String toString() => 'Album(id: $id, userId: $userId, title: $title)';
} 