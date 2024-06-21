import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/tasks_provider.dart';
import 'task_form.dart';

class TaskDetails extends StatefulWidget {
  final Task task;

  const TaskDetails({Key? key, required this.task}) : super(key: key);

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  late Task _task;

  @override
  void initState() {
    super.initState();
    _task = widget.task;
  }

  void _updateTask(Task updatedTask) async {
    try {
      await Provider.of<TasksProvider>(context, listen: false)
          .updateTask(updatedTask);
      final updated = Provider.of<TasksProvider>(context, listen: false)
          .getTaskById(updatedTask.id);
      if (updated != null) {
        setState(() {
          _task = updated;
        });
      }
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final updatedTask = await showDialog<Task>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: TaskForm(
                      formMode: FormMode.Edit,
                      task: _task,
                    ),
                  );
                },
              );

              if (updatedTask != null) {
                _updateTask(updatedTask);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Content: ${_task.name}', style: TextStyle(fontSize: 18)),
            Text('Completed: ${_task.completed ? "Yes" : "No"}',
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
