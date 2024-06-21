enum Priority { low, normal, high }

class Task {
  final String id;
  final String name;
  final bool completed;
  final Priority priority;
  final String userId;

  Task({
    required this.id,
    required this.name,
    this.completed = false,
    this.priority = Priority.normal,
    required this.userId,
  });

  Task copyWith(
      {String? id,
      String? name,
      bool? completed,
      Priority? priority,
      String? userId}) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      completed: completed ?? this.completed,
      priority: priority ?? this.priority,
      userId: userId ?? this.userId,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      completed: json['completed'],
      priority: Priority.values[json['priority']],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'completed': completed,
      'priority': priority.index,
      'user_id': userId,
    };
  }
}
