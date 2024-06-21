import 'package:flutter/material.dart';
import '../models/task.dart';
import '../screens/task_details.dart';

class TaskPreview extends StatelessWidget {
  final Task task;

  TaskPreview({required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.name),
      tileColor: task.completed ? Colors.green[100] : Colors.red[100],
      trailing: Icon(task.completed ? Icons.check : Icons.error),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetails(task: task),
          ),
        );
      },
    );
  }
}
