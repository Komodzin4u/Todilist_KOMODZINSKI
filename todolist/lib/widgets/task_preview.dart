import 'package:flutter/material.dart';
import '../models/task.dart';
import '../screens/task_details.dart';

class TaskPreview extends StatelessWidget {
  final Task task;

  TaskPreview({required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(task.name, style: TextStyle(fontWeight: FontWeight.bold)),
        tileColor: task.completed ? Colors.green[100] : Colors.red[100],
        trailing: Icon(task.completed ? Icons.check_circle : Icons.error,
            color: task.completed ? Colors.green : Colors.red),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetails(task: task),
            ),
          );
        },
      ),
    );
  }
}
