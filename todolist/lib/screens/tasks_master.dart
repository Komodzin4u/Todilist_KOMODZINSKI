import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tasks_provider.dart';
import '../models/task.dart';
import '../widgets/task_preview.dart';
import 'task_form.dart';

class TasksMaster extends StatefulWidget {
  @override
  _TasksMasterState createState() => _TasksMasterState();
}

class _TasksMasterState extends State<TasksMaster> {
  @override
  void initState() {
    super.initState();
    Provider.of<TasksProvider>(context, listen: false).fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Consumer<TasksProvider>(
        builder: (context, tasksProvider, child) {
          if (tasksProvider.tasks.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: tasksProvider.tasks.length,
              itemBuilder: (context, index) {
                return TaskPreview(task: tasksProvider.tasks[index]);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final bool taskCreated = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskForm()),
          );
          if (taskCreated != null && taskCreated) {
            await Provider.of<TasksProvider>(context, listen: false)
                .fetchTasks();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
