import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:madcampweek2/home_page.dart';

class ApiService {
  //static const String serverIp = 'http://143.248.184.42:3000';
  static const String serverIp = 'http://192.249.28.37:3000';

  static const String authBase = '$serverIp/api/auth';
  static const String sessionBase = '$serverIp/api/session';
  static const String gitBase = '$serverIp/api/gitController';
  static const String domainBase = '$serverIp/api/domain';
  static const String searchBase = '$serverIp/api/search';

  // -------------------------
  // AUTH
  // -------------------------
  static Future<http.Response> register(
    String email,
    String password,
    String username,
  ) async {
    final url = Uri.parse('$authBase/register');
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

  static Future<http.Response> login(String email, String password) async {
    final url = Uri.parse('$authBase/login');
    final body = jsonEncode({'email': email, 'password': password});
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
  }

  static Future<http.Response> getUserId(String token) async {
    final url = Uri.parse('$authBase/user');
    final headers = {'Authorization': 'Bearer $token'};
    return await http.get(url, headers: headers);
  }

  Future<void> sendCodeToBackend(String code, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('$authBase/github/code'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'code': code}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];

        if (!context.mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage(token: token)),
        );
      } else {
        debugPrint('❌ 서버 인증 실패: ${response.body}');
      }
    } catch (e) {
      debugPrint('❌ 서버 요청 오류: $e');
    }
  }

  // -------------------------
  // SESSION / DOCKER
  // -------------------------
  static Future<http.Response> getSession(String token, String userId) async {
    final url = Uri.parse('$sessionBase/get?user_id=$userId');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return await http.get(url, headers: headers);
  }

  static Future<http.Response> dockerBuild(
    String token,
    String userId,
    String localPath,
    String imageName,
  ) async {
    final url = Uri.parse('$sessionBase/build');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({
      'user_id': userId,
      'localPath': localPath,
      'imageName': imageName,
    });
    return await http.post(url, headers: headers, body: body);
  }

  static Future<http.Response> dockerRun(
    String token,
    String sessionId,
    String cpu,
    String memory,
    String port,
  ) async {
    final url = Uri.parse('$domainBase/run');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({
      'session_id': sessionId,
      'cpu': cpu,
      'memory': memory,
      'port': port,
    });
    return await http.post(url, headers: headers, body: body);
  }

  static Future<http.Response> getContainerStatus(
    String containerId,
    String token,
  ) async {
    final url = Uri.parse('$sessionBase/status/$containerId');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return await http.get(url, headers: headers);
  }

  static Future<http.Response> stopContainer(
    String token,
    String containerId,
    String sessionId,
  ) async {
    final url = Uri.parse('$sessionBase/stop');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({
      'containerId': containerId,
      'sessionId': sessionId,
    });
    return await http.post(url, headers: headers, body: body);
  }

  static Future<http.Response> removeContainer(
    String containerId,
    String token,
  ) async {
    final url = Uri.parse('$sessionBase/remove/$containerId');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return await http.delete(url, headers: headers);
  }

  // -------------------------
  // GIT
  // -------------------------
  static Future<http.Response> getCloneRepo(String token, String userId) async {
    final url = Uri.parse('$gitBase/cloned-repos/$userId');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return await http.get(url, headers: headers);
  }

  static Future<http.Response> cloneRepo(String repoUrl, String token) async {
    final url = Uri.parse('$gitBase/clone-repo');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({'repoUrl': repoUrl});
    return await http.post(url, headers: headers, body: body);
  }

  // -------------------------
  // SEArCH
  // -------------------------
  static Future<List<dynamic>> getUsefulLinks() async {
    final url = Uri.parse('$searchBase/links');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (body is List) return body;
      throw Exception('Server returned invalid links data.');
    } else {
      throw Exception('Failed to load links');
    }
  }

  static Future<List<dynamic>> searchPostsByTag(String tag) async {
    final url = Uri.parse('$searchBase/posts/search?tag=$tag');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (body is List) return body;
      throw Exception('Server returned invalid search results.');
    } else {
      throw Exception('Failed to search posts');
    }
  }

  static Future<void> incrementView(String postId) async {
    final url = Uri.parse('$searchBase/posts/$postId/view');
    final response = await http.post(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to increment view');
    }
  }

  static Future<Map<String, dynamic>> getPostById(String postId) async {
    final url = Uri.parse('$searchBase/posts/$postId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (body is Map) {
        return Map<String, dynamic>.from(body);
      }
      throw Exception('Invalid post data.');
    } else {
      throw Exception('Failed to get post');
    }
  }

  static Future<void> addAnswer(String postId, String text) async {
    final url = Uri.parse('$searchBase/posts/$postId/answers');
    final body = jsonEncode({'text': text});
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add answer');
    }
  }

  // ✅ Corrected: Use GET /searchGoogle?q=...
  static Future<List<dynamic>> crawlGoogleAndGetResults(String query) async {
    final url = Uri.parse('$searchBase/searchGoogle?q=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is List) return decoded;
      throw Exception('Server returned invalid crawl results.');
    } else {
      throw Exception('Failed to crawl and get Google results');
    }
  }

  static Future<List<dynamic>> fetchCommunityUsers(String token) async {
    final response = await http.get(
      Uri.parse('$serverIp/api/community/people'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }
}
