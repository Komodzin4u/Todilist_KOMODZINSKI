import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'providers/tasks_provider.dart';
import 'providers/user_provider.dart';
import 'app.dart'; // Importer la classe ToDoListApp

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(TodoListApp());
}

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TasksProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const ToDoListApp(),
    );
  }
}
