import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/task.dart';

class TaskService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: '${dotenv.env['SUPABASE_URL']}/rest/v1',
    headers: {
      'apikey': dotenv.env['API_KEY']!,
      'Authorization': 'Bearer ${dotenv.env['SUPABASE_ANON_KEY']!}',
    },
  ));

  Future<List<Task>> fetchTasks() async {
    final response = await _dio.get('/tasks');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> createNewTask(Task task) async {
    final response = await _dio.post('/tasks', data: task.toJson());
    print('Create task response: ${response.statusCode}');
  }

  Future<void> updateTask(Task task) async {
    print('Updating task: ${task.toJson()}');
    final response =
        await _dio.patch('/tasks?id=eq.${task.id}', data: task.toJson());
    print('Update task response: ${response.statusCode}');
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(String id) async {
    final response = await _dio.delete('/tasks?id=eq.$id');
    print('Delete task response: ${response.statusCode}');
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete task');
    }
  }
}
