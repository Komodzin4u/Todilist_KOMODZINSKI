import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/task.dart';

class TaskService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: dotenv.env['SUPABASE_URL']!,
    headers: {
      'apikey': dotenv.env['API_KEY']!,
      'Authorization': 'Bearer ${dotenv.env['SUPABASE_ANON_KEY']!}',
    },
  ));

  Future<List<Task>> fetchTasks() async {
    final response = await _dio.get('/rest/v1/tasks');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> createNewTask(Task task) async {
    await _dio.post('/rest/v1/tasks', data: task.toJson());
  }

  Future<void> updateTask(Task task) async {
    await _dio.put('/rest/v1/tasks/${task.id}', data: task.toJson());
  }

  Future<void> deleteTask(String id) async {
    await _dio.delete('/rest/v1/tasks/$id');
  }
}
