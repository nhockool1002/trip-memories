import 'dart:convert';

class MemoryItem {
  const MemoryItem({
    required this.id,
    required this.title,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
    this.note = '',
    this.imagePaths = const [],
  });

  final String id;
  final String title;
  final String note;
  final double latitude;
  final double longitude;
  final List<String> imagePaths;
  final DateTime createdAt;
  final DateTime updatedAt;

  MemoryItem copyWith({
    String? id,
    String? title,
    String? note,
    double? latitude,
    double? longitude,
    List<String>? imagePaths,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MemoryItem(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      imagePaths: imagePaths ?? this.imagePaths,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'latitude': latitude,
      'longitude': longitude,
      'image_paths': jsonEncode(imagePaths),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory MemoryItem.fromMap(Map<String, Object?> map) {
    final rawImagePaths = map['image_paths'] as String? ?? '[]';
    final decodedImagePaths = jsonDecode(rawImagePaths) as List<dynamic>;

    return MemoryItem(
      id: map['id'] as String,
      title: map['title'] as String,
      note: map['note'] as String? ?? '',
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      imagePaths: decodedImagePaths.cast<String>(),
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }
}
