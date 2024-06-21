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

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      priority: Priority.values
          .firstWhere((e) => e.toString() == 'Priority.${json['priority']}'),
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'priority': priority.toString().split('.').last,
      'completed': completed,
    };
  }

  void completeTask() {
    completed = true;
  }

  @override
  String toString() {
    return 'Task{id: $id, name: $name, priority: $priority, completed: $completed}';
  }
}
