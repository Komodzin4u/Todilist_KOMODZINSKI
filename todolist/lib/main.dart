import 'package:flutter/material.dart';
import 'screens/tasks_master.dart';

void main() {
  runApp(TodoListApp());
}

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      home: TasksMaster(),
    );
  }
}
