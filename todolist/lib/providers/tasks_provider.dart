import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class TasksProvider with ChangeNotifier {
  List<Task> _tasks = [];
  final TaskService _taskService = TaskService();

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async {
    _tasks = await _taskService.fetchTasks();
    print("Tasks fetched: ${_tasks.length}");
    notifyListeners();
  }

  void addTask(Task task) {
    _taskService.createTask(task);
    notifyListeners();
  }

  Task? getTaskById(String id) {
    try {
      return _tasks.firstWhere((task) => task.id == id);
    } catch (e) {
      return null;
    }
  }

  void removeTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
}
