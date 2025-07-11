import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ApiService {
  // 서버 주소 설정 (실제 IP 주소 사용)
  static const String baseUrl = 'http://143.248.183.61:3000/api/auth'; // 실제 서버의 IP로 설정
  // static const String baseUrl = 'http://10.0.2.2:3000/api/auth'; // 실제 서버의 IP로 설정


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

  // // Git 리포지토리 클론 함수
  // static Future<http.Response> cloneRepo(String repoUrl) async {
  //   // 서버 IP 주소를 그대로 사용
  //   // final url = Uri.parse('http://143.248.183.61:3000/api/gitController/clone-repo');
  //   final url = Uri.parse('http://10.0.2.2:3000/api/gitController/clone-repo');
  //
  //   final headers = {
  //     'Content-Type': 'application/json',
  //   };
  //
  //   final body = jsonEncode({'repoUrl': repoUrl});
  //
  //   try {
  //     final response = await http.post(url, headers: headers, body: body);
  //
  //     if (response.statusCode == 200) {
  //       // 성공적으로 클론된 경우
  //       print('Git 리포지토리 클론 성공!');
  //       print('서버 응답: ${response.body}');
  //     } else {
  //       // 클론 실패한 경우
  //       print('Error: ${response.statusCode}');
  //       print('서버 응답: ${response.body}');
  //     }
  //
  //     return response;  // 서버의 응답을 반환
  //   } catch (e) {
  //     // 네트워크 오류 처리
  //     print('Git 리포지토리 클론 요청 중 오류 발생: $e');
  //     return Future.error('클론 요청 실패: $e');  // 오류 발생 시
  //   }
  // }
  // Git 리포지토리 클론 함수 (토큰을 Authorization 헤더에 포함)
  static Future<http.Response> cloneRepo(String repoUrl, String token) async {
    // final url = Uri.parse('http://10.0.2.2:3000/api/gitController/clone-repo');
    final url = Uri.parse('http://143.248.183.61:3000/api/gitController/clone-repo');


    // 헤더에 Authorization 토큰 포함
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',  // Bearer 형식으로 토큰 추가
    };

    final body = jsonEncode({'repoUrl': repoUrl});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // 성공적으로 클론된 경우
        print('Git 리포지토리 클론 성공!');
        print('서버 응답: ${response.body}');
      } else {
        // 클론 실패한 경우
        print('Error: ${response.statusCode}');
        print('서버 응답: ${response.body}');
      }

      return response;  // 서버의 응답을 반환
    } catch (e) {
      // 네트워크 오류 처리
      print('Git 리포지토리 클론 요청 중 오류 발생: $e');
      return Future.error('클론 요청 실패: $e');  // 오류 발생 시
    }
  }

}
