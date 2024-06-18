import 'package:flutter/material.dart';
import 'package:todolist/services/task_service.dart';
import 'package:todolist/models/task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var taskService = TaskService();
  var tasks = await taskService.fetchTasks();
  for (var task in tasks) {
    print(task);
  }
  runApp(TodoListApp());
}

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Todo List'),
        ),
        body: Center(
          child: Text('Bienvenue sur TodoList!'),
        ),
      ),
    );
  }
}
