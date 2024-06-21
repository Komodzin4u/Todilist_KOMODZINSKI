import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tasks_provider.dart';
import '../widgets/task_preview.dart';
import 'task_form.dart';
import '../models/task.dart';

class TasksMaster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks Master'),
      ),
      body: Consumer<TasksProvider>(
        builder: (context, tasksProvider, child) {
          return FutureBuilder(
            future: tasksProvider.tasksFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error loading tasks'));
              } else {
                final tasks = snapshot.data as List<Task>;
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskPreview(task: tasks[index]);
                  },
                );
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: TaskForm(formMode: FormMode.Add),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
