import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tasks_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/task_preview.dart';

class TasksMaster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (userProvider.user != null) {
      tasksProvider.fetchTasks();
    }

    return Scaffold(
      appBar: AppBar(title: Text('Tasks')),
      body: Consumer<TasksProvider>(
        builder: (context, tasksProvider, child) {
          if (tasksProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (tasksProvider.tasks.isEmpty) {
            return Center(child: Text('No tasks found'));
          }
          return ListView.builder(
            itemCount: tasksProvider.tasks.length,
            itemBuilder: (context, index) {
              return TaskPreview(task: tasksProvider.tasks[index]);
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
