enum Priority { low, normal, high }

class Task {
  final String id;
  final String content;
  final bool completed;
  final Priority priority;

  Task({
    required this.id,
    required this.content,
    this.completed = false,
    this.priority = Priority.normal,
  });

  Task copyWith(
      {String? id, String? content, bool? completed, Priority? priority}) {
    return Task(
      id: id ?? this.id,
      content: content ?? this.content,
      completed: completed ?? this.completed,
      priority: priority ?? this.priority,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      content: json['content'],
      completed: json['completed'],
      priority: Priority.values[json['priority']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'completed': completed,
      'priority': priority.index,
    };
  }
}
