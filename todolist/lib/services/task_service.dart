import 'dart:async';
import 'package:faker/faker.dart';
import '../models/task.dart';

class TaskService {
  static final TaskService _singleton = TaskService._internal();
  factory TaskService() {
    return _singleton;
  }
  TaskService._internal();

  final List<Task> _tasks = [];

  Future<List<Task>> fetchTasks() async {
    if (_tasks.isEmpty) {
      var faker = Faker();
      for (int i = 0; i < 10; i++) {
        _tasks.add(Task(
          id: faker.guid.guid(),
          userId: faker.guid.guid(),
          content: faker.lorem.sentence(),
          completed: faker.randomGenerator.boolean(),
        ));
      }
    }
    await Future.delayed(Duration(seconds: 2));
    return _tasks;
  }

  void createTask(Task task) {
    _tasks.add(task);
  }

  void updateTask(Task task) {
    int index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
    }
  }
}
