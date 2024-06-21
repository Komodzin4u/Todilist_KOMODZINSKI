import 'package:uuid/uuid.dart';

enum Priority { low, normal, high }

class Task {
  final String id;
  String name;
  Priority priority;
  bool completed;

  Task({
    String? id,
    required this.name,
    required this.priority,
    this.completed = false,
  }) : id = id ?? const Uuid().v4();

  void completeTask() {
    completed = true;
  }

  @override
  String toString() {
    return 'Task{id: $id, name: $name, priority: $priority, completed: $completed}';
  }
}
