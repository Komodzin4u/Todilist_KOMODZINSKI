import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class TasksProvider with ChangeNotifier {
  List<Task> _tasks = [];
  final TaskService _taskService = TaskService();

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async {
    _tasks = await _taskService.fetchTasks();
    notifyListeners();
  }

  void addTask(Task task) {
    _taskService.createTask(task);
    _tasks.add(task);
    print("Task added: ${task.id}, ${task.content}, ${task.completed}");
    notifyListeners();
  }

  void updateTask(Task task) {
    int index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      _taskService.updateTask(task);
      print(
          "Task updated in provider: ${task.id}, ${task.content}, ${task.completed}");
      notifyListeners();
    } else {
      print("Task not found: ${task.id}");
    }
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
