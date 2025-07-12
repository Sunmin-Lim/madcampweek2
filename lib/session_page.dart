import 'package:flutter/material.dart';
import 'api_service.dart'; // ApiService 임포트 (Docker 빌드 관련 함수)
import 'dart:convert';

class SessionPage extends StatefulWidget {
  final String token;
  final String repoUrl;

  const SessionPage({super.key, required this.token, required this.repoUrl});

  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  String message = ''; // 서버 응답 메시지 저장 변수

  // Docker 빌드에 필요한 값들
  late String userId; // userId를 동적으로 설정
  late String username;
  late String localPath;
  String basePath =
      '/home/hanjeongjin/Workspace_ubuntu/backend/madcampweek2-backend/F:/workspace/server_manage/home';
  // String localPath =
  //     '/home/hanjeongjin/Workspace_ubuntu/backend/madcampweek2-backend/cloned-repo-test'; // 임의로 설정한 localPath
  String imageName = 'custom-image-name'; // 임의로 설정한 imageName
  String cpu = '0.5'; // 임의로 설정한 CPU 리소스
  String memory = '200MB'; // 임의로 설정한 메모리 리소스

  bool isLoading = true; // userId를 가져오는 동안 로딩 상태 관리

  // userId를 API에서 가져오는 함수 (username도 함께 받기)
  Future<void> getUserInfo() async {
    try {
      final response = await ApiService.getUserId(
        widget.token,
      ); // getUser API 호출
      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body); // JSON으로 변환된 사용자 데이터
        setState(() {
          userId = userData['userId']; // userId 추출
          username = userData['username']; // username 추출
          String repoName = widget.repoUrl
              .split('/')
              .last
              .replaceAll('.git', ''); // repoName 추출
          localPath = '$basePath/$username/$repoName'; // 동적으로 localPath 설정
          isLoading = false; // 로딩 완료
        });
      } else {
        setState(() {
          message = 'Error: ${response.body}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        message = 'Error retrieving user info: $e';
        isLoading = false;
      });
    }
  }

  // Docker 빌드 함수
  void buildDockerContainer() async {
    if (isLoading) {
      setState(() {
        message = 'Loading user data...';
      });
      return;
    }

    // userId가 로드되었을 때만 Docker 빌드를 진행하도록 함
    if (userId.isEmpty) {
      setState(() {
        message = 'User ID is not available.';
      });
      return;
    }

    setState(() {
      message = 'Docker 빌드 중...';
    });

    try {
      final response = await ApiService.dockerBuild(
        widget.repoUrl, // 전달받은 repoUrl 사용
        widget.token,
        userId, // 동적으로 설정된 userId 사용
        localPath, // 임의로 설정된 localPath 사용
        imageName, // 임의로 설정된 imageName 사용
        cpu, // 임의로 설정된 cpu 리소스 사용
        memory, // 임의로 설정된 memory 리소스 사용
      ); // Docker 빌드 요청

      if (response.statusCode == 200) {
        setState(() {
          message = 'Docker 빌드 성공!';
        });
      } else {
        setState(() {
          message = 'Docker 빌드 실패: ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Docker 빌드 중 오류 발생: $e';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserInfo(); // 페이지가 로드될 때 userId를 가져오는 함수 호출
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Docker 빌드')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // userId가 로드될 때까지 Docker 빌드 버튼 비활성화
            isLoading
                ? const CircularProgressIndicator() // 로딩 중일 때
                : ElevatedButton(
                    onPressed: buildDockerContainer,
                    child: const Text('Build Docker Image'),
                  ),
            const SizedBox(height: 20),
            // 빌드 성공/실패 메시지 표시
            Text(
              message,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
