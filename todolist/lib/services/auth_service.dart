import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class AuthService {
  final Dio _dio = Dio();
  final String _baseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  final String _apiKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<bool> signIn(String email, String password) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/auth/v1/token?grant_type=password',
        data: {'email': email, 'password': password},
        options: Options(headers: {'apikey': _apiKey}),
      );

      if (response.statusCode == 200) {
        String accessToken = response.data['access_token'];
        String refreshToken = response.data['refresh_token'];

        await _storage.write(key: 'accessToken', value: accessToken);
        await _storage.write(key: 'refreshToken', value: refreshToken);
        await _storage.write(
            key: 'userData', value: jsonEncode(response.data['user']));

        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<void> signOut() async {
    try {
      String? refreshToken = await _storage.read(key: 'refreshToken');
      await _dio.post(
        '$_baseUrl/auth/v1/logout',
        options: Options(
          headers: {
            'apikey': _apiKey,
            'Authorization': 'Bearer $refreshToken',
          },
        ),
      );
    } catch (e) {
      print(e);
    } finally {
      await _storage.deleteAll();
    }
  }

  Future<bool> refreshAuthToken() async {
    try {
      String? refreshToken = await _storage.read(key: 'refreshToken');
      final response = await _dio.post(
        '$_baseUrl/auth/v1/token?grant_type=refresh_token',
        data: {'refresh_token': refreshToken},
        options: Options(headers: {'apikey': _apiKey}),
      );

      if (response.statusCode == 200) {
        String accessToken = response.data['access_token'];
        await _storage.write(key: 'accessToken', value: accessToken);
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<Map<String, dynamic>?> getUserData() async {
    String? userData = await _storage.read(key: 'userData');
    if (userData != null) {
      return jsonDecode(userData);
    }
    return null;
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'accessToken');
  }

  Future<String?> getStoredRefreshToken() async {
    return await _storage.read(key: 'refreshToken');
  }
}
