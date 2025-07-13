import 'dart:async';

import 'package:flutter/material.dart';
import 'api_service.dart';
import 'dart:convert';
import 'register_page.dart'; // 회원가입 페이지 import
import 'home_page.dart'; // 로그인 성공 후 이동할 홈 화면 import
import 'package:url_launcher/url_launcher.dart';
import 'package:app_links/app_links.dart';

import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
// import 'package:flutter_appauth/flutter_appauth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  static const String serverIp = 'http://143.248.183.61:3000';
  static const String authBase = '$serverIp/api/auth';
  String message = '';
  StreamSubscription<Uri>? _linkSubscription;

  void login() async {
    final response = await ApiService.login(
      emailController.text,
      passwordController.text,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      setState(() {
        message = '로그인 성공! 토큰: $token';
      });

      // 로그인 성공 시 HomePage로 토큰을 넘겨서 이동
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomePage(token: token)), // HomePage로 token 전달
      // );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(token: token),
        ), // const 제거
      );
    } else {
      setState(() {
        message = jsonDecode(response.body)['message'];
      });
    }
  }

  void _handleIncomingLinks() {
    final appLinks = AppLinks();
    _linkSubscription?.cancel();

    _linkSubscription = appLinks.uriLinkStream.listen(
      (uri) {
        print('📥 수신된 딥링크 URI: $uri');

        if (uri.toString().startsWith('myapp://callback')) {
          final code = uri.queryParameters['code'];
          print('✅ 앱에서 받은 GitHub code: $code');

          if (code != null && code.isNotEmpty) {
            final apiService = ApiService();
            apiService.sendCodeToBackend(code, context);
          }
        }
      },
      onError: (err) {
        print('❌ 딥링크 수신 중 오류: $err');
      },
    );
  }

  void loginWithGitHub() async {
    const clientId = 'Ov23liBt79Q7o2NROraV';
    const redirectUri = 'myapp://callback';

    final authUrl = Uri.parse(
      'https://github.com/login/oauth/authorize'
      '?client_id=$clientId'
      '&redirect_uri=$redirectUri'
      '&scope=user:email',
    );

    try {
      if (await canLaunchUrl(authUrl)) {
        await launchUrl(authUrl, mode: LaunchMode.externalApplication);
      } else {
        print('❌ GitHub 로그인 페이지 열기 실패');
      }
    } catch (e) {
      print('❌ GitHub 로그인 실패: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: const Text('로그인')),
            ElevatedButton(
              onPressed: loginWithGitHub,
              child: const Text('GitHub 로그인'),
            ),
            TextButton(
              onPressed: () {
                // 회원가입 페이지로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: const Text('회원가입 하러 가기'),
            ),
            const SizedBox(height: 20),
            Text(message),
          ],
        ),
      ),
    );
  }
}
