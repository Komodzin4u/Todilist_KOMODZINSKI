import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'providers/tasks_provider.dart';
import 'providers/user_provider.dart';
import 'services/auth_service.dart';
import 'todo_list_app.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(TodoListApp());
}
