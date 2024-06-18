import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskDetails extends StatelessWidget {
  final Task task;

  TaskDetails({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Content: ${task.content}'),
            SizedBox(height: 8),
            Text('Completed: ${task.completed ? "Yes" : "No"}'),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}
