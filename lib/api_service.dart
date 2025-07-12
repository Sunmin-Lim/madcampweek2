import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class ApiService {
  // 서버 주소 설정 (실제 IP 주소 사용)
  static const String baseUrl =
      'http://143.248.183.61:3000/api/auth'; // 실제 서버의 IP로 설정
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
    final url = Uri.parse(
      'http://143.248.183.61:3000/api/gitController/clone-repo',
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
      'http://143.248.183.61:3000/api/auth/user',
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
    String repoUrl,
    String token,
    String userId, // user_id 추가
    String localPath,
    String imageName,
    String cpu,
    String memory,
  ) async {
    final url = Uri.parse(
      'http://143.248.183.61:3000/api/session/build-run',
    ); // 실제 API URL

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Bearer 형식으로 토큰 추가
    };

    final body = jsonEncode({
      'user_id': userId, // user_id를 본문에 포함
      'localPath': localPath, // localPath 포함
      'imageName': imageName, // imageName 포함
      'resources': {
        // CPU 및 메모리 리소스 포함
        'cpu': cpu,
        'memory': memory,
      },
      'repoUrl': repoUrl, // repoUrl 포함
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      return response;
    } catch (e) {
      print('Docker 빌드 요청 중 오류 발생: $e');
      return Future.error('빌드 요청 실패: $e');
    }
  }

  static Future<http.Response> createAndRunContainer(
    String userId,
    String localPath,
    String imageName,
    String cpu,
    String memory,
    String token,
  ) async {
    final url = Uri.parse('http://143.248.183.61:3000/api/session/build-run');

    final body = jsonEncode({
      'user_id': userId,
      'localPath': localPath,
      'imageName': imageName,
      'resources': {'cpu': cpu, 'memory': memory},
    });

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.post(url, headers: headers, body: body);
      return response;
    } catch (e) {
      print('Error creating container: $e');
      return Future.error('Error creating container: $e');
    }
  }

  static Future<http.Response> getSessions(String userId, String token) async {
    final url = Uri.parse(
      'http://143.248.183.61:3000/api/session?user_id=$userId',
    );

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(url, headers: headers);
      return response;
    } catch (e) {
      print('Error fetching sessions: $e');
      return Future.error('Error fetching sessions: $e');
    }
  }

  static Future<http.Response> getContainerStatus(
    String containerId,
    String token,
  ) async {
    final url = Uri.parse(
      'http://143.248.183.61:3000/api/session/status/$containerId',
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
    String containerId,
    String sessionId,
    String token,
  ) async {
    final url = Uri.parse('http://143.248.183.61:3000/api/session/stop');

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
      'http://143.248.183.61:3000/api/session/remove/$containerId',
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
