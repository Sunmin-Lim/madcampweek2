import 'package:flutter/material.dart';
import 'api_service.dart';
import 'dart:convert';
import 'register_page.dart'; // 회원가입 페이지 import
import 'home_page.dart'; // 로그인 성공 후 이동할 홈 화면 import
import 'package:url_launcher/url_launcher.dart';
// import 'package:uni_links/uni_links.dart';
// import 'dart:async';

import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String message = '';

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

  void launchGitHubLogin(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      ); // 외부 브라우저에서 열기
    } else {
      throw 'GitHub 로그인 페이지를 열 수 없습니다: $url';
    }
  }

  // void loginWithGitHub() async {
  //   try {
  //     final result = await FlutterWebAuth2.authenticate(
  //       url: 'http://your-server.com/api/auth/github', // 백엔드 로그인 시작 URL
  //       callbackUrlScheme: 'myapp', // 딥링크에서 정의한 스킴
  //     );

  //     final token = Uri.parse(result).queryParameters['token'];
  //     print('✅ 로그인 성공! 받은 토큰: $token');

  //     // 토큰 저장 또는 다음 화면 이동
  //   } catch (e) {
  //     print('❌ 로그인 실패: $e');
  //   }
  // }

  void loginWithGitHub() async {
    // GitHub OAuth 클라이언트 ID와 리다이렉트 URI 설정
    // 🔁 리다이렉트 URI는 AndroidManifest.xml에 등록되어 있어야

    // Ov23liBt79Q7o2NROraV
    // const clientId = 'YOUR_CLIENT_ID';
    const clientId = 'Ov23liBt79Q7o2NROraV'; // GitHub OAuth 클라이언트 ID

    const redirectUri = 'myapp://callback'; // 🔁 AndroidManifest에 등록된 딥링크
    final url = Uri.parse(
      'https://github.com/login/oauth/authorize?client_id=$clientId&redirect_uri=$redirectUri&scope=user:email',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch GitHub login';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28.0,
                vertical: 24.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    '앱 이름',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Whale Emoji as Logo
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text('🐳', style: TextStyle(fontSize: 80)),
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'enter your email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'enter your password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'login',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'sign up',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // GitHub Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        const githubLoginUrl =
                            'https://d1cb4fb6166e.ngrok-free.app/api/auth/github';
                        launchGitHubLogin(githubLoginUrl);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'gitHub login',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const SizedBox(height: 12),
                  if (message.isNotEmpty) ...[
                    Text(message, style: const TextStyle(color: Colors.red)),
                  ],
                  const SizedBox(height: 24),
                  Text(
                    'WhaleDev 2025',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
