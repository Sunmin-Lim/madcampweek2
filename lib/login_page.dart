import 'package:flutter/material.dart';
import 'api_service.dart';
import 'dart:convert';
import 'register_page.dart'; // 회원가입 페이지 import
import 'home_page.dart'; // 로그인 성공 후 이동할 홈 화면 import

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String message = '';

  // void login() async {
  //   final response = await ApiService.login(
  //     emailController.text,
  //     passwordController.text,
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     final token = data['token'];
  //
  //     setState(() {
  //       message = '로그인 성공! 토큰: $token';
  //     });
  //
  //     // 로그인 성공 시 홈 화면으로 이동
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const HomePage()),
  //     );
  //   } else {
  //     setState(() {
  //       message = jsonDecode(response.body)['message'];
  //     });
  //   }
  // }
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
