import 'package:flutter/material.dart';
import 'package:todolist/services/task_service.dart';
import 'package:todolist/models/task.dart';

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
    _taskService.createNewTask(newTask);
    refreshTasks();
  }

  Task? getTaskById(String id) {
    return _tasksMap[id];
  }

  void updateTask(Task updatedTask) {
    _tasksMap[updatedTask.id] = updatedTask;
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasksMap.remove(id);
    notifyListeners();
  }
}
