import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/task_model.dart';
import '../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Users collection reference
  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection('users');

  // Tasks subcollection for a user
  CollectionReference<Map<String, dynamic>> _tasksForUser(String userId) {
    return _users.doc(userId).collection('tasks');
  }

  // User Methods

  /// Creates a new user profile document in Firestore
  Future<void> createUserProfile(String uid, String email, String? name) async {
    try {
      if (uid.isEmpty) {
        throw ArgumentError('User ID cannot be empty');
      }
      if (email.isEmpty) {
        throw ArgumentError('Email cannot be empty');
      }

      final userDoc = _users.doc(uid);
      final userModel = UserModel(
        uid: uid,
        email: email.trim(),
        name: name?.trim(),
        streakCount: 0,
        focusHours: 0,
        tasksCompleted: 0,
        createdAt: DateTime.now(),
      );

      await userDoc.set(userModel.toMap());
    } catch (e) {
      throw Exception('Failed to create user profile: $e');
    }
  }

  /// Retrieves a user profile by UID
  Future<UserModel?> getUserProfile(String uid) async {
    try {
      if (uid.isEmpty) {
        throw ArgumentError('User ID cannot be empty');
      }

      final snapshot = await _users.doc(uid).get();
      if (!snapshot.exists || snapshot.data() == null) {
        return null;
      }

      return UserModel.fromMap(snapshot.data()!, snapshot.id);
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }

  /// Updates user statistics
  Future<void> updateUserStats(
    String uid, {
    int? streakCount,
    int? focusHours,
    int? tasksCompleted,
  }) async {
    try {
      if (uid.isEmpty) {
        throw ArgumentError('User ID cannot be empty');
      }

      final updates = <String, dynamic>{};
      if (streakCount != null) updates['streakCount'] = streakCount;
      if (focusHours != null) updates['focusHours'] = focusHours;
      if (tasksCompleted != null) updates['tasksCompleted'] = tasksCompleted;

      if (updates.isEmpty) return;

      await _users.doc(uid).update(updates);
    } catch (e) {
      throw Exception('Failed to update user stats: $e');
    }
  }

  // Task Methods

  /// Creates a new task for a user
  Future<void> createTask(String userId, TaskModel task) async {
    try {
      if (userId.isEmpty) {
        throw ArgumentError('User ID cannot be empty');
      }
      if (task.title.trim().isEmpty) {
        throw ArgumentError('Task title cannot be empty');
      }

      final taskRef = _tasksForUser(userId).doc();
      final taskWithId = task.copyWith(id: taskRef.id, userId: userId);
      await taskRef.set(taskWithId.toMap());
    } catch (e) {
      throw Exception('Failed to create task: $e');
    }
  }

  /// Retrieves all tasks for a user
  Future<List<TaskModel>> getUserTasks(String userId) async {
    try {
      if (userId.isEmpty) {
        throw ArgumentError('User ID cannot be empty');
      }

      final snapshot = await _tasksForUser(
        userId,
      ).orderBy('createdAt', descending: true).get();

      return snapshot.docs
          .map((doc) => TaskModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to get user tasks: $e');
    }
  }

  /// Toggles the completion status of a task
  Future<void> toggleTaskComplete(String taskId, bool isCompleted) async {
    try {
      if (taskId.isEmpty) {
        throw ArgumentError('Task ID cannot be empty');
      }

      // Note: This assumes taskId is unique across all users.
      // In a production app, you might want to store userId with taskId or use a different approach.
      // For now, we'll search across all users' tasks (not efficient for large datasets)
      final usersSnapshot = await _users.get();
      for (final userDoc in usersSnapshot.docs) {
        final taskRef = _tasksForUser(userDoc.id).doc(taskId);
        final taskSnapshot = await taskRef.get();
        if (taskSnapshot.exists) {
          await taskRef.update({'isCompleted': isCompleted});
          return;
        }
      }
      throw Exception('Task not found');
    } catch (e) {
      throw Exception('Failed to toggle task completion: $e');
    }
  }

  /// Deletes a task
  Future<void> deleteTask(String taskId) async {
    try {
      if (taskId.isEmpty) {
        throw ArgumentError('Task ID cannot be empty');
      }

      // Similar to toggleTaskComplete, search across all users
      final usersSnapshot = await _users.get();
      for (final userDoc in usersSnapshot.docs) {
        final taskRef = _tasksForUser(userDoc.id).doc(taskId);
        final taskSnapshot = await taskRef.get();
        if (taskSnapshot.exists) {
          await taskRef.delete();
          return;
        }
      }
      throw Exception('Task not found');
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }

  /// Streams the current user's profile in real-time
  Stream<UserModel?> streamUserProfile() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return Stream.value(null);
    return streamUserProfileById(uid);
  }

  /// Streams all tasks for a user in real-time
  Stream<List<TaskModel>> streamUserTasks(String userId) {
    try {
      if (userId.isEmpty) {
        throw ArgumentError('User ID cannot be empty');
      }

      return _tasksForUser(userId)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => TaskModel.fromMap(doc.data(), doc.id))
                .toList(),
          );
    } catch (e) {
      throw Exception('Failed to stream user tasks: $e');
    }
  }

  /// Streams a user profile by UID in real-time
  Stream<UserModel?> streamUserProfileById(String uid) {
    try {
      if (uid.isEmpty) {
        throw ArgumentError('User ID cannot be empty');
      }

      return _users.doc(uid).snapshots().map((snapshot) {
        if (!snapshot.exists || snapshot.data() == null) return null;
        return UserModel.fromMap(snapshot.data()!, snapshot.id);
      });
    } catch (e) {
      throw Exception('Failed to stream user profile: $e');
    }
  }
}
