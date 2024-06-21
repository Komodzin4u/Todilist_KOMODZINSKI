import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/tasks_provider.dart';
import '../screens/task_details.dart';

class TaskPreview extends StatelessWidget {
  final Task task;

  TaskPreview({required this.task});

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context, listen: false);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(task.name),
        subtitle: Text('Priority: ${task.priority.toString().split('.').last}'),
        trailing: Checkbox(
          value: task.completed,
          onChanged: (bool? value) async {
            Task updatedTask = task.copyWith(completed: value ?? false);
            await tasksProvider.updateTask(updatedTask);
          },
        ),
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
