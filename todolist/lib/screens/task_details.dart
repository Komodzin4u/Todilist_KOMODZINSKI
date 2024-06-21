import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/tasks_provider.dart';

class TaskDetails extends StatelessWidget {
  final Task task;

  TaskDetails({required this.task});

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
    Task _task = task;

    return Scaffold(
      appBar: AppBar(title: Text('Task Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Content: ${_task.content}'),
            Text('Completed: ${_task.completed ? 'Yes' : 'No'}'),
            ElevatedButton(
              onPressed: () {
                tasksProvider.deleteTask(_task.id);
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
            ElevatedButton(
              onPressed: () async {
                _task = _task.copyWith(
                    completed: !_task
                        .completed); // Utilisation de copyWith pour modifier l'état
                await tasksProvider.updateTask(_task);
                try {
                  var updated = tasksProvider.getTaskById(_task.id);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TaskDetails(task: updated)),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to find task')),
                  );
                }
              },
              child: Text(
                  _task.completed ? 'Mark as Incomplete' : 'Mark as Complete'),
            ),
          ],
        ),
      ),
    );
  }
}
