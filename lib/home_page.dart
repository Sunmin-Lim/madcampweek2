// import 'package:flutter/material.dart';
// import 'api_service.dart'; // ApiService 임포트 (Git 클론 관련 함수)
// import 'dart:convert';

// class HomePage extends StatefulWidget {
//   final String token; // 로그인 후 받은 토큰을 받아올 변수

//   const HomePage({super.key, required this.token}); // 생성자를 통해 token을 전달받음

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final TextEditingController repoUrlController =
//       TextEditingController(); // Git URL 입력 받기 위한 컨트롤러
//   String message = ''; // 서버 응답 메시지 저장 변수

//   // Git 리포지토리 클론 함수
//   void cloneRepo() async {
//     final repoUrl = repoUrlController.text.trim(); // 입력된 URL 가져오기

//     if (repoUrl.isEmpty) {
//       setState(() {
//         message = '리포지토리 URL을 입력해주세요.';
//       });
//       return;
//     }

//     // 받은 토큰을 로그로 출력
//     print("Received Token: ${widget.token}");

//     try {
//       final response = await ApiService.cloneRepo(
//         repoUrl,
//         widget.token,
//       ); // 토큰을 함께 넘겨서 클론 요청

//       if (response.statusCode == 200) {
//         setState(() {
//           message = 'Git 리포지토리 클론 성공!';
//         });
//       } else {
//         setState(() {
//           message = 'Error: ${response.body}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         message = 'Git 리포지토리 클론 중 오류가 발생했습니다. 오류: $e';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Git 리포지토리 클론')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Git 리포지토리 URL 입력 필드
//             TextField(
//               controller: repoUrlController,
//               decoration: const InputDecoration(
//                 labelText: 'Git Repository URL',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             // 클론 버튼
//             ElevatedButton(
//               onPressed: cloneRepo,
//               child: const Text('Clone Repository'),
//             ),
//             const SizedBox(height: 20),
//             // 클론 성공/실패 메시지 표시
//             Text(
//               message,
//               style: const TextStyle(fontSize: 16, color: Colors.black),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'api_service.dart'; // ApiService 임포트 (Git 클론 관련 함수)
// import 'dart:convert';
// import 'session_page.dart'; // SessionPage 임포트

// class HomePage extends StatefulWidget {
//   final String token; // 로그인 후 받은 토큰을 받아올 변수

//   const HomePage({super.key, required this.token}); // 생성자를 통해 token을 전달받음

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final TextEditingController repoUrlController =
//       TextEditingController(); // Git URL 입력 받기 위한 컨트롤러
//   String message = ''; // 서버 응답 메시지 저장 변수

//   // Git 리포지토리 클론 함수
//   void cloneRepo() async {
//     final repoUrl = repoUrlController.text.trim(); // 입력된 URL 가져오기

//     if (repoUrl.isEmpty) {
//       setState(() {
//         message = '리포지토리 URL을 입력해주세요.';
//       });
//       return;
//     }

//     // 받은 토큰을 로그로 출력
//     print("Received Token: ${widget.token}");

//     try {
//       final response = await ApiService.cloneRepo(
//         repoUrl,
//         widget.token,
//       ); // 토큰을 함께 넘겨서 클론 요청

//       if (response.statusCode == 200) {
//         setState(() {
//           message = 'Git 리포지토리 클론 성공!';
//         });

//         // Git 클론이 성공적으로 완료되면 session_page로 이동
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => SessionPage(
//               token: widget.token,
//               repoUrl: repoUrl, // repoUrl 전달
//             ),
//           ),
//         );
//       } else {
//         setState(() {
//           message = 'Error: ${response.body}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         message = 'Git 리포지토리 클론 중 오류가 발생했습니다. 오류: $e';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Git 리포지토리 클론')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Git 리포지토리 URL 입력 필드
//             TextField(
//               controller: repoUrlController,
//               decoration: const InputDecoration(
//                 labelText: 'Git Repository URL',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             // 클론 버튼
//             ElevatedButton(
//               onPressed: cloneRepo,
//               child: const Text('Clone Repository'),
//             ),
//             const SizedBox(height: 20),
//             // 클론 성공/실패 메시지 표시
//             Text(
//               message,
//               style: const TextStyle(fontSize: 16, color: Colors.black),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'api_service.dart'; // ApiService 임포트 (Git 클론 관련 함수)
import 'dart:convert';
import 'session_page.dart'; // SessionPage 임포트

class HomePage extends StatefulWidget {
  final String token; // 로그인 후 받은 토큰을 받아올 변수

  const HomePage({super.key, required this.token}); // 생성자를 통해 token을 전달받음

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController repoUrlController =
      TextEditingController(); // Git URL 입력 받기 위한 컨트롤러
  String message = ''; // 서버 응답 메시지 저장 변수

  // Git 리포지토리 클론 함수
  void cloneRepo() async {
    final repoUrl = repoUrlController.text.trim(); // 입력된 URL 가져오기

    if (repoUrl.isEmpty) {
      setState(() {
        message = '리포지토리 URL을 입력해주세요.';
      });
      return;
    }

    // 받은 토큰을 로그로 출력
    print("Received Token: ${widget.token}");

    try {
      final response = await ApiService.cloneRepo(
        repoUrl,
        widget.token,
      ); // 토큰을 함께 넘겨서 클론 요청

      if (response.statusCode == 200) {
        setState(() {
          message = 'Git 리포지토리 클론 성공!';
        });

        // Git 클론이 성공적으로 완료되면 session_page로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SessionPage(
              token: widget.token,
              repoUrl: repoUrl, // repoUrl 전달
            ),
          ),
        );
      } else {
        setState(() {
          message = 'Error: ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Git 리포지토리 클론 중 오류가 발생했습니다. 오류: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Git 리포지토리 클론')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Git 리포지토리 URL 입력 필드
            TextField(
              controller: repoUrlController,
              decoration: const InputDecoration(
                labelText: 'Git Repository URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // 클론 버튼
            ElevatedButton(
              onPressed: cloneRepo,
              child: const Text('Clone Repository'),
            ),
            const SizedBox(height: 20),
            // 클론 성공/실패 메시지 표시
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
