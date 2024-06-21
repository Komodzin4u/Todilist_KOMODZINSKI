import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/tasks_provider.dart';
import '../widgets/task_preview.dart';

class TaskMaster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tasks')),
      body: Consumer<TasksProvider>(
        builder: (context, tasksProvider, child) {
          return FutureBuilder(
            future: tasksProvider.tasksFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                List<Task> tasks = snapshot.data as List<Task>;
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskPreview(task: tasks[index]);
                  },
                );
              } else {
                return Center(child: Text('No tasks found'));
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/task_form');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
