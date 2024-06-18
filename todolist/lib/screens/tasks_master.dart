import 'package:flutter/material.dart';
import '../services/task_service.dart';
import '../models/task.dart';
import '../widgets/task_preview.dart';
import 'task_form.dart';

class TasksMaster extends StatefulWidget {
  @override
  _TasksMasterState createState() => _TasksMasterState();
}

class _TasksMasterState extends State<TasksMaster> {
  late Future<List<Task>> _tasksFuture;
  final TaskService _taskService = TaskService();

  @override
  void initState() {
    super.initState();
    _tasksFuture = _taskService.fetchTasks();
  }

  void _refreshTasks() {
    setState(() {
      _tasksFuture = _taskService.fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: FutureBuilder<List<Task>>(
        future: _tasksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tasks available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return TaskPreview(task: snapshot.data![index]);
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
            _refreshTasks();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
