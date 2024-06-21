import 'package:flutter/material.dart';
import '../models/task.dart';
import 'task_form.dart';

class TaskDetails extends StatelessWidget {
  final Task task;

  const TaskDetails({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: TaskForm(formMode: FormMode.Edit, task: task),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Content: ${task.name}', style: TextStyle(fontSize: 18)),
            Text('Completed: ${task.completed ? "Yes" : "No"}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
