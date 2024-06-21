import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: '${dotenv.env['SUPABASE_URL']}/auth/v1',
    headers: {
      'apikey': dotenv.env['API_KEY']!,
    },
  ));

  String? _accessToken;
  String? _refreshToken;

  Future<void> signIn(String email, String password) async {
    try {
      final response = await _dio.post('/token?grant_type=password', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        _accessToken = response.data['access_token'];
        _refreshToken = response.data['refresh_token'];
        print('Access Token: $_accessToken');
        print('Refresh Token: $_refreshToken');
      } else {
        throw Exception('Failed to sign in');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        throw Exception(
            'Failed to sign in: ${e.response?.data['error_description']}');
      } else {
        print('Error: ${e.message}');
        throw Exception('Failed to sign in: ${e.message}');
      }
    }
  }

  Future<void> signOut() async {
    try {
      final response = await _dio.post('/logout',
          options: Options(headers: {
            'Authorization': 'Bearer $_accessToken',
          }));

      if (response.statusCode == 200) {
        _accessToken = null;
        _refreshToken = null;
      } else {
        throw Exception('Failed to sign out');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        throw Exception(
            'Failed to sign out: ${e.response?.data['error_description']}');
      } else {
        print('Error: ${e.message}');
        throw Exception('Failed to sign out: ${e.message}');
      }
    }
  }

  Future<void> refreshAuthToken() async {
    try {
      final response =
          await _dio.post('/token?grant_type=refresh_token', data: {
        'refresh_token': _refreshToken,
      });

      if (response.statusCode == 200) {
        _accessToken = response.data['access_token'];
        _refreshToken = response.data['refresh_token'];
        print('New Access Token: $_accessToken');
        print('New Refresh Token: $_refreshToken');
      } else {
        throw Exception('Failed to refresh token');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        throw Exception(
            'Failed to refresh token: ${e.response?.data['error_description']}');
      } else {
        print('Error: ${e.message}');
        throw Exception('Failed to refresh token: ${e.message}');
      }
    }
  }

  String? get accessToken => _accessToken;
  String? get refreshTokenValue =>
      _refreshToken; // Renommé pour éviter les conflits
}
