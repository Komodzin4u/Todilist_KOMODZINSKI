import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tasks_provider.dart';
import '../widgets/task_preview.dart';

class TasksMaster extends StatefulWidget {
  @override
  _TasksMasterState createState() => _TasksMasterState();
}

class _TasksMasterState extends State<TasksMaster> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<TasksProvider>(context, listen: false).fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
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
