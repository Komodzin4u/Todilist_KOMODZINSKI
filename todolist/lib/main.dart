import 'package:flutter/material.dart';

void main() {
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
          child: Text('Bienvenue sur mon app Todo List!'),
        ),
      ),
    );
  }
}
