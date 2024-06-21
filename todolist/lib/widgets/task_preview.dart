import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskPreview extends StatelessWidget {
  final Task task;

  TaskPreview({required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.content),
      subtitle: Text('Priority: ${task.priority.toString().split('.').last}'),
      trailing: Checkbox(
        value: task.completed,
        onChanged: (bool? value) {
          // Update task completion status
        },
      ),
    );
  }
}
