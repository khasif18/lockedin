import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String userId;
  final String title;
  final bool isCompleted;
  final bool isFavorite;
  final DateTime createdAt;

  TaskModel({
    required this.id,
    required this.userId,
    required this.title,
    this.isCompleted = false,
    this.isFavorite = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      isFavorite: json['isFavorite'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'isCompleted': isCompleted,
      'isFavorite': isFavorite,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Firestore deserialization
  factory TaskModel.fromMap(Map<String, dynamic> map, String documentId) {
    final rawCreatedAt = map['createdAt'];

    DateTime convertedCreatedAt;
    if (rawCreatedAt is Timestamp) {
      convertedCreatedAt = rawCreatedAt.toDate();
    } else if (rawCreatedAt is DateTime) {
      convertedCreatedAt = rawCreatedAt;
    } else {
      convertedCreatedAt = DateTime.now();
    }

    return TaskModel(
      id: documentId,
      userId: (map['userId'] as String?) ?? '',
      title: (map['title'] as String?)?.trim() ?? '',
      isCompleted: (map['isCompleted'] as bool?) ?? false,
      isFavorite: (map['isFavorite'] as bool?) ?? false,
      createdAt: convertedCreatedAt,
    );
  }

  /// Firestore serialization
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'isCompleted': isCompleted,
      'isFavorite': isFavorite,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  @override
  String toString() {
    return 'TaskModel(id: $id, userId: $userId, title: $title, isCompleted: $isCompleted, isFavorite: $isFavorite, createdAt: $createdAt)';
  }

  TaskModel copyWith({
    String? id,
    String? userId,
    String? title,
    bool? isCompleted,
    bool? isFavorite,
    DateTime? createdAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
