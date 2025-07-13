import 'package:flutter/material.dart';
import 'api_service.dart';
import 'dart:convert';
import 'register_page.dart'; // 회원가입 페이지 import
import 'home_page.dart'; // 로그인 성공 후 이동할 홈 화면 import
import 'package:url_launcher/url_launcher.dart';
import 'package:app_links/app_links.dart';

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

  // void loginWithGitHub() async {
  //   // GitHub OAuth 클라이언트 ID와 리다이렉트 URI 설정
  //   // 🔁 리다이렉트 URI는 AndroidManifest.xml에 등록되어 있어야

  //   // Ov23liBt79Q7o2NROraV
  //   // const clientId = 'YOUR_CLIENT_ID';
  //   const clientId = 'Ov23liBt79Q7o2NROraV'; // GitHub OAuth 클라이언트 ID

  //   const redirectUri = 'myapp://callback'; // 🔁 AndroidManifest에 등록된 딥링크
  //   final url = Uri.parse(
  //     'https://github.com/login/oauth/authorize'
  //     '?client_id=$clientId'
  //     '&redirect_uri=$redirectUri'
  //     '&scope=user:email',
  //   );

  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url, mode: LaunchMode.externalApplication);
  //   } else {
  //     throw 'GitHub 로그인 페이지를 열 수 없습니다.';
  //   }
  // }

  // void loginWithGitHub() async {
  //   const clientId = 'Ov23liBt79Q7o2NROraV';
  //   const redirectUri = 'myapp://callback';

  //   print('🚀 [loginWithGitHub] 함수 진입');

  //   final authUrl = Uri.parse(
  //     'https://github.com/login/oauth/authorize'
  //     '?client_id=$clientId'
  //     '&redirect_uri=$redirectUri'
  //     '&scope=user:email',
  //   );
  //   print('🔗 [GitHub OAuth] 인증 URL: $authUrl');

  //   try {
  //     // ✅ 딥링크가 myapp://callback?code=... 형식으로 오면 자동으로 여기서 기다림
  //     print('⏳ [OAuth] FlutterWebAuth2.authenticate 시작...');

  //     final result = await FlutterWebAuth2.authenticate(
  //       url: authUrl.toString(),
  //       callbackUrlScheme: 'myapp',
  //     );

  //     print('📦 [OAuth] redirect URI result: $result');

  //     // ✅ 리디렉션된 URI에서 code 추출
  //     final code = Uri.parse(result).queryParameters['code'];
  //     print('📥 [OAuth] 받은 code: $code');

  //     if (code != null) {
  //       // TODO: 백엔드에 code를 전송해 JWT 토큰을 교환 (추후 구현)
  //     } else {
  //       print('❌ code 파라미터가 없음');
  //     }
  //   } catch (e) {
  //     print('❌ GitHub OAuth 실패: $e');
  //   }
  // }

  void loginWithGitHub() async {
    const clientId = 'Ov23liBt79Q7o2NROraV';
    const redirectUri = 'myapp://callback';

    final authUrl = Uri.parse(
      'https://github.com/login/oauth/authorize'
      '?client_id=$clientId'
      '&redirect_uri=$redirectUri'
      '&scope=user:email',
    );

    print('🔗 Launching GitHub OAuth URL: $authUrl');

    if (await canLaunchUrl(authUrl)) {
      await launchUrl(authUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'GitHub 로그인 페이지 열기 실패';
    }
  }

  void _handleIncomingLinks() {
    final appLinks = AppLinks();

    appLinks.uriLinkStream.listen((uri) {
      if (uri.toString().startsWith('myapp://callback')) {
        final code = uri.queryParameters['code'];
        print('✅ 앱에서 받은 GitHub code: $code');

        if (code != null) {
          final apiService = ApiService();
          apiService.sendCodeToBackend(code, context);
        }
      }
    });
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
