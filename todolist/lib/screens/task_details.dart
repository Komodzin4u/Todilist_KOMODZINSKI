import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/tasks_provider.dart';
import 'task_form.dart';

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
        child: TaskForm(
          formMode: FormMode.Edit,
          task: task,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Task? updatedTask = await showDialog<Task>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Edit Task'),
                content: TaskForm(
                  formMode: FormMode.Edit,
                  task: task,
                ),
              );
            },
          );

          if (updatedTask != null) {
            print(
                "Updated Task received: ${updatedTask.id}, ${updatedTask.content}, ${updatedTask.completed}");
            Provider.of<TasksProvider>(context, listen: false)
                .updateTask(updatedTask);
            Navigator.pop(context); // Retourner à la liste des tâches
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
