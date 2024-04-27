import 'package:dio/dio.dart';

final dio = Dio();

class UserApi {
  static Future<Response> register(String username, String password, String email) async {
    try {
      final response = await dio.post(
        'https://10.0.2.2:7012/User/RegisterUser',
        data: {
          'username': username,
          'password': password,
          'email': email,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> login(String username, String password) async {
    try {
      final response = await dio.post(
        'https://10.0.2.2:7012/User/LoginUser',
        data: {'username': username, 'password': password},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
