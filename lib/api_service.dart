import 'dart:convert';
//import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class ApiService {
  // 서버 주소 설정 (실제 IP 주소 사용)

  static const String baseUrl = 'http://143.248.184.42:3000/api/auth';

  //  'http://143.248.183.61:3000/api/auth'; // 실제 서버의 IP로 설정
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

  // Git 리포지토리 클론 함수 (토큰을 Authorization 헤더에 포함)
  static Future<http.Response> cloneRepo(String repoUrl, String token) async {
    // final url = Uri.parse('http://10.0.2.2:3000/api/gitController/clone-repo');
    final url = Uri.parse(
      //'http://143.248.183.61:3000/api/gitController/clone-repo'
      'http://143.248.183.42:3000/api/gitController/clone-repo',
    );

    // 헤더에 Authorization 토큰 포함
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Bearer 형식으로 토큰 추가
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

      return response; // 서버의 응답을 반환
    } catch (e) {
      // 네트워크 오류 처리
      print('Git 리포지토리 클론 요청 중 오류 발생: $e');
      return Future.error('클론 요청 실패: $e'); // 오류 발생 시
    }
  }

  static Future<http.Response> getUserId(String token) async {
    final url = Uri.parse(
      // 'http://143.248.183.61:3000/api/auth/user',
      'http://143.248.183.42:3000/api/auth/user',
    ); // 사용자 ID를 가져오는 API URL

    final headers = {
      'Authorization': 'Bearer $token', // Bearer 형식으로 토큰 추가
    };

    try {
      final response = await http.get(url, headers: headers);
      return response;
    } catch (e) {
      print('사용자 ID 요청 중 오류 발생: $e');
      return Future.error('사용자 ID 요청 실패: $e');
    }
  }

  static Future<http.Response> dockerBuild(
    String token,
    String userId, // user_id 추가
    String localPath,
    String imageName,
  ) async {
    final url = Uri.parse(
      //'http://143.248.183.61:3000/api/session/build',
      'http://143.248.183.42:3000/api/session/build',
    ); // 실제 API URL

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Bearer 형식으로 토큰 추가
    };

    final body = jsonEncode({
      'user_id': userId, // user_id를 본문에 포함
      'localPath': localPath, // localPath 포함
      'imageName': imageName, // imageName 포함
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      return response;
    } catch (e) {
      print('Docker 빌드 요청 중 오류 발생: $e');
      return Future.error('빌드 요청 실패: $e');
    }
  }

  static Future<http.Response> getSession(String token, String userId) async {
    final url = Uri.parse(
      //'http://143.248.183.61:3000/api/session/get?user_id=$userId', // 쿼리 파라미터로 user_id 전달
      'http://143.248.183.42:3000/api/session/get?user_id=$userId', // 쿼리 파라미터로 user_id 전달
    );

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Bearer 형식으로 토큰 추가
    };

    try {
      final response = await http.get(url, headers: headers); // GET 방식으로 요청
      return response;
    } catch (e) {
      print('Error retrieving session: $e');
      return Future.error('Error retrieving session: $e');
    }
  }

  static Future<http.Response> dockerRun(
    String token,
    String sessionId,
    String cpu,
    String memory,
    String port,
  ) async {
    final url = Uri.parse(
      //'http://143.248.183.61:3000/api/domain/run',
      'http://143.248.183.42:3000/api/domain/run',
    ); // 실제 API URL

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Bearer 형식으로 토큰 추가
    };

    final body = jsonEncode({
      'session_id': sessionId,
      'cpu': cpu,
      'memory': memory,
      'port': port,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      // 응답 상태 코드와 본문 출력
      print('Docker Run Response Status Code: ${response.statusCode}');
      print('Docker Run Response Body: ${response.body}');

      // 응답 상태 코드 확인
      if (response.statusCode == 200) {
        return response;
      } else {
        return Future.error('Docker container 실행 실패: ${response.body}');
      }
    } catch (e) {
      print('API/domain/run | dockerRun | FAIL: $e');
      return Future.error('API/domain/run | dockerRun | FAIL: $e');
    }
  }

  static Future<http.Response> getContainerStatus(
    String containerId,
    String token,
  ) async {
    final url = Uri.parse(
      //'http://143.248.183.61:3000/api/session/status/$containerId',
      'http://143.248.183.42:3000/api/session/status/$containerId',
    );

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(url, headers: headers);
      return response;
    } catch (e) {
      print('Error fetching container status: $e');
      return Future.error('Error fetching container status: $e');
    }
  }

  static Future<http.Response> stopContainer(
    String token,
    String containerId,
    String sessionId,
  ) async {
    //final url = Uri.parse('http://143.248.183.61:3000/api/session/stop');
    final url = Uri.parse('http://143.248.183.42:3000/api/session/stop');

    final body = jsonEncode({
      'containerId': containerId,
      'sessionId': sessionId,
    });

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.post(url, headers: headers, body: body);
      return response;
    } catch (e) {
      print('Error stopping container: $e');
      return Future.error('Error stopping container: $e');
    }
  }

  static Future<http.Response> removeContainer(
    String containerId,
    String token,
  ) async {
    final url = Uri.parse(
      //'http://143.248.183.61:3000/api/session/remove/$containerId',
      'http://143.248.183.42:3000/api/session/remove/$containerId',
    );

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.delete(url, headers: headers);
      return response;
    } catch (e) {
      print('Error removing container: $e');
      return Future.error('Error removing container: $e');
    }
  }
}
