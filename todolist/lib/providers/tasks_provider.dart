import 'package:flutter/material.dart';
import '../services/task_service.dart';
import '../models/task.dart';

class TasksProvider extends ChangeNotifier {
  final TaskService _taskService = TaskService();
  late Future<List<Task>> _tasksFuture;
  final Map<String, Task> _tasksMap = {};

  TasksProvider() {
    _tasksFuture = _fetchAndCacheTasks();
  }

  Future<List<Task>> get tasksFuture => _tasksFuture;

  Future<List<Task>> _fetchAndCacheTasks() async {
    List<Task> tasks = await _taskService.fetchTasks();
    _tasksMap.clear();
    for (var task in tasks) {
      _tasksMap[task.id] = task;
    }
    return tasks;
  }

  void refreshTasks() {
    _tasksFuture = _fetchAndCacheTasks();
    notifyListeners();
  }

  Future<void> createNewTask(Task newTask) async {
    await _taskService.createNewTask(newTask);
    refreshTasks();
  }

  Task? getTaskById(String id) {
    return _tasksMap[id];
  }

  Future<void> updateTask(Task updatedTask) async {
    await _taskService.updateTask(updatedTask);
    _tasksMap[updatedTask.id] = updatedTask;
    notifyListeners();
  }

  Future<void> deleteTask(String id) async {
    await _taskService.deleteTask(id);
    _tasksMap.remove(id);
    notifyListeners();
  }
}
