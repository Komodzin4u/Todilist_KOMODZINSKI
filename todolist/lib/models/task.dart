enum Priority { low, normal, high }

class Task {
  final String id;
  final String name;
  final bool completed;
  final Priority priority;

  Task({
    required this.id,
    required this.name,
    this.completed = false,
    this.priority = Priority.normal,
  });

  Task copyWith(
      {String? id, String? name, bool? completed, Priority? priority}) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      completed: completed ?? this.completed,
      priority: priority ?? this.priority,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      completed: json['completed'],
      priority: Priority.values[json['priority']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'completed': completed,
      'priority': priority.index,
    };
  }
}
