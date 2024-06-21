import 'dart:math';
import 'package:faker/faker.dart';
import '../models/task.dart';

class TaskService {
  List<Task> tasks = [];

  Future<List<Task>> fetchTasks() async {
    if (tasks.isEmpty) {
      var faker = Faker();
      var random = Random();

      tasks = List.generate(10, (index) {
        return Task(
          name: faker.lorem.sentence(),
          priority: Priority.values[random.nextInt(Priority.values.length)],
          completed: random.nextBool(),
        );
      });
      return tasks;
    } else {
      return tasks;
    }
  }

  void createNewTask(Task task) {
    tasks.add(task);
  }

  void updateTask(Task updatedTask) {
    int index = tasks.indexWhere((t) => t.id == updatedTask.id);
    if (index != -1) {
      tasks[index] = updatedTask;
    }
  }
}
