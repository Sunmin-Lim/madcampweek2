import 'package:flutter/material.dart';
import 'api_service.dart';
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  String message = '';

  void register() async {
    final response = await ApiService.register(
      emailController.text,
      passwordController.text,
      usernameController.text,
    );

    setState(() {
      if (response.statusCode == 201) {
        message = jsonDecode(response.body)['message'];
      } else {
        message = jsonDecode(response.body)['message'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원가입')),
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
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: register, child: const Text('회원가입')),
            const SizedBox(height: 20),
            Text(message),
          ],
        ),
      ),
    );
  }
}
