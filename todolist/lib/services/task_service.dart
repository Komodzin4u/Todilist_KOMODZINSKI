import 'dart:async';
import 'package:faker/faker.dart';
import '../models/task.dart';
import '../models/user.dart';

class TaskService {
  Future<List<Task>> fetchTasks() async {
    var faker = Faker();
    List<Task> tasks = [];

    for (int i = 0; i < 100; i++) {
      tasks.add(Task(
        userId: faker.guid.guid(),
        content: faker.lorem.sentence(),
        completed: faker.randomGenerator.boolean(),
      ));
    }

    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    return tasks;
  }
}
