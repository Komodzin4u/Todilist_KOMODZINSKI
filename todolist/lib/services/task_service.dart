import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'auth_service.dart';
import '../models/task.dart';

class TaskService {
  final Dio _dio = Dio();
  final String _baseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  final String _apiKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  final AuthService authService = AuthService();

  Future<List<Task>> fetchTasks() async {
    try {
      String? token = await authService.getAccessToken();
      final response = await _dio.get(
        '$_baseUrl/rest/v1/tasks',
        options: Options(headers: {
          'apikey': _apiKey,
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        List data = response.data;
        return data.map((task) => Task.fromJson(task)).toList();
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<void> createNewTask(Task task) async {
    try {
      String? token = await authService.getAccessToken();
      await _dio.post(
        '$_baseUrl/rest/v1/tasks',
        data: task.toJson(),
        options: Options(headers: {
          'apikey': _apiKey,
          'Authorization': 'Bearer $token',
        }),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      String? token = await authService.getAccessToken();
      await _dio.put(
        '$_baseUrl/rest/v1/tasks/${task.id}',
        data: task.toJson(),
        options: Options(headers: {
          'apikey': _apiKey,
          'Authorization': 'Bearer $token',
        }),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      String? token = await authService.getAccessToken();
      await _dio.delete(
        '$_baseUrl/rest/v1/tasks/$id',
        options: Options(headers: {
          'apikey': _apiKey,
          'Authorization': 'Bearer $token',
        }),
      );
    } catch (e) {
      print(e);
    }
  }
}
