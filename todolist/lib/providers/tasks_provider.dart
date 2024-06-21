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

  Future<void> addTask(Task task) async {
    await _taskService.createNewTask(task);
    _tasks.add(task);
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    await _taskService.updateTask(task);
    int index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      notifyListeners();
    }
  }

  Future<void> deleteTask(String id) async {
    await _taskService.deleteTask(id);
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  Task getTaskById(String id) {
    return _tasks.firstWhere((task) => task.id == id,
        orElse: () => throw Exception('Task not found'));
  }

  Future<List<Task>> get tasksFuture async {
    await fetchTasks();
    return tasks;
  }
}
