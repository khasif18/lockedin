import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String? name;
  final int streakCount;
  final int focusHours;
  final int tasksCompleted;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.email,
    this.name,
    this.streakCount = 0,
    this.focusHours = 0,
    this.tasksCompleted = 0,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      streakCount: json['streakCount'] as int? ?? 0,
      focusHours: json['focusHours'] as int? ?? 0,
      tasksCompleted: json['tasksCompleted'] as int? ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'streakCount': streakCount,
      'focusHours': focusHours,
      'tasksCompleted': tasksCompleted,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Firestore deserialization
  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    final rawCreatedAt = map['createdAt'];

    DateTime convertedCreatedAt;
    if (rawCreatedAt is Timestamp) {
      convertedCreatedAt = rawCreatedAt.toDate();
    } else if (rawCreatedAt is DateTime) {
      convertedCreatedAt = rawCreatedAt;
    } else {
      convertedCreatedAt = DateTime.now();
    }

    return UserModel(
      uid: documentId,
      name: (map['name'] as String?)?.trim(),
      email: (map['email'] as String?)?.trim() ?? '',
      createdAt: convertedCreatedAt,
      streakCount: (map['streakCount'] as num?)?.toInt() ?? 0,
      focusHours: (map['focusHours'] as num?)?.toInt() ?? 0,
      tasksCompleted: (map['tasksCompleted'] as num?)?.toInt() ?? 0,
    );
  }

  /// Firestore serialization
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'createdAt': Timestamp.fromDate(createdAt),
      'streakCount': streakCount,
      'focusHours': focusHours,
      'tasksCompleted': tasksCompleted,
    };
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, name: $name, streakCount: $streakCount, focusHours: $focusHours, tasksCompleted: $tasksCompleted, createdAt: $createdAt)';
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    int? streakCount,
    int? focusHours,
    int? tasksCompleted,
    DateTime? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      streakCount: streakCount ?? this.streakCount,
      focusHours: focusHours ?? this.focusHours,
      tasksCompleted: tasksCompleted ?? this.tasksCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
