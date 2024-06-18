import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/tasks_master.dart';
import 'providers/tasks_provider.dart';

void main() {
  runApp(TodoListApp());
}

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TasksProvider(),
      child: MaterialApp(
        title: 'Todo List',
        home: TasksMaster(),
      ),
    );
  }
}
