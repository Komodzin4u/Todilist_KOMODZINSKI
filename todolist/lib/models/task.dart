import 'package:uuid/uuid.dart';

enum Priority { low, normal, high }

class Task {
  final String id;
  final String userId;
  final String content;
  final List<String> tags;
  final bool completed;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? dueDate;
  final Priority priority;

  Task({
    String? id,
    required this.userId,
    required this.content,
    this.tags = const [],
    this.completed = false,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.dueDate,
    this.priority = Priority.normal,
  })  : id = id ?? Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  @override
  String toString() {
    return 'Task(id: $id, userId: $userId, content: $content, completed: $completed, priority: $priority)';
  }
}
