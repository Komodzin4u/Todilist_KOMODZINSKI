import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'auth_service.dart';
import '../models/task.dart';

class TaskService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: '${dotenv.env['SUPABASE_URL']}/rest/v1',
    headers: {
      'apikey': dotenv.env['API_KEY']!,
    },
  ));

  Future<List<Task>> fetchTasks() async {
    final authService =
        AuthService(); // Assurez-vous d'avoir accès au service d'authentification
    final response = await _dio.get('/tasks',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${authService.accessToken}',
          },
        ));
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> createNewTask(Task task) async {
    final authService =
        AuthService(); // Assurez-vous d'avoir accès au service d'authentification
    final response = await _dio.post(
      '/tasks',
      data: task.toJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer ${authService.accessToken}',
        },
      ),
    );
    print('Create task response: ${response.statusCode}');
    if (response.statusCode != 201) {
      throw Exception('Failed to create task');
    }
  }

  Future<void> updateTask(Task task) async {
    final authService =
        AuthService(); // Assurez-vous d'avoir accès au service d'authentification
    print('Updating task: ${task.toJson()}');
    final response = await _dio.patch(
      '/tasks?id=eq.${task.id}',
      data: task.toJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer ${authService.accessToken}',
        },
      ),
    );
    print('Update task response: ${response.statusCode}');
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(String id) async {
    final authService =
        AuthService(); // Assurez-vous d'avoir accès au service d'authentification
    final response = await _dio.delete(
      '/tasks?id=eq.$id',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${authService.accessToken}',
        },
      ),
    );
    print('Delete task response: ${response.statusCode}');
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete task');
    }
  }
}
