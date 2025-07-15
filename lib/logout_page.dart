import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'api_service.dart';
import 'login_page.dart';

class LogoutPage extends StatefulWidget {
  final String token;
  const LogoutPage({super.key, required this.token});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  late VideoPlayerController _videoController;
  bool _videoInitialized = false;
  String message = '';

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() async {
    _videoController = VideoPlayerController.asset('assets/videos/whale.mp4');
    await _videoController.initialize();
    _videoController.setLooping(true);
    _videoController.play();

    setState(() {
      _videoInitialized = true;
    });
  }

  // void logout() async {
  //   final response = await ApiService.logout(widget.token);

  //   if (response.statusCode == 200) {
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (_) => const LoginPage()),
  //       (route) => false,
  //     );
  //   } else {
  //     setState(() {
  //       message = jsonDecode(response.body)['message'] ?? '로그아웃 실패';
  //     });
  //   }
  // }

  // 연결 해제하기
  void logout() async {
    final response = await ApiService.logout(widget.token);

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false,
        );
      } catch (e) {
        print('❌ JSON 디코딩 실패: $e');
        print('📄 응답 본문: ${response.body}');
        setState(() {
          message = 'Invalid server response.';
        });
      }
    } else {
      print('❌ 로그아웃 실패: ${response.statusCode}');
      print('📄 응답 본문: ${response.body}');
      setState(() {
        message = 'Logout failed.';
      });
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
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
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    'Are you sure you\nwant to logout?',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // Whale Video
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: _videoInitialized
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: VideoPlayer(_videoController),
                          )
                        : const Center(child: CircularProgressIndicator()),
                  ),

                  const SizedBox(height: 32),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'logout',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  if (message.isNotEmpty)
                    Text(
                      message,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),

                  const SizedBox(height: 24),
                  Text(
                    'BackOverFlow 2025',
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
