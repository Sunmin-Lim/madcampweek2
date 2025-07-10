import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // 내 백엔드 서버 주소를 상황에 맞게 바꾸자!
  static const String baseUrl = 'http://localhost:3000/api/auth';
  // Android 에뮬레이터는 localhost 대신 10.0.2.2를 써야 함
  // iOS 시뮬레이터면 'http://localhost:3000/api/auth' 사용 가능

  // 회원가입 함수
  static Future<http.Response> register(
    String email,
    String password,
    String username,
  ) async {
    final url = Uri.parse('$baseUrl/register');
    final body = jsonEncode({
      'email': email,
      'password': password,
      'username': username,
    });

    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
  }

  // 로그인 함수
  static Future<http.Response> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final body = jsonEncode({'email': email, 'password': password});

    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
  }
}
