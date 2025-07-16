// // import 'package:flutter/material.dart';

// // class ArchivePage extends StatelessWidget {
// //   final String token;
// //   final String repoUrl;

// //   const ArchivePage({super.key, required this.token, required this.repoUrl});

// //   // sudo_archive/add

// //   // sudo_archive/push

// //   // github 링크 만들기

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Archive'),
// //         backgroundColor: Colors.blueGrey,
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             const Icon(Icons.archive, size: 100, color: Colors.blueGrey),
// //             const SizedBox(height: 16),
// //             const Text(
// //               'Archive Page Placeholder',
// //               style: TextStyle(fontSize: 20),
// //             ),
// //             const SizedBox(height: 8),
// //             Text(
// //               'Token: $token',
// //               style: const TextStyle(fontSize: 14, color: Colors.grey),
// //             ),
// //             Text(
// //               'Repo URL: $repoUrl',
// //               style: const TextStyle(fontSize: 14, color: Colors.grey),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'api_service.dart';
// import 'package:url_launcher/url_launcher.dart'; // url_launcher 패키지 임포트

// class ArchivePage extends StatefulWidget {
//   final String token;
//   final String repoUrl;

//   const ArchivePage({super.key, required this.token, required this.repoUrl});

//   @override
//   _ArchivePageState createState() => _ArchivePageState();
// }

// class _ArchivePageState extends State<ArchivePage> {
//   final TextEditingController _userNameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   // SSH 계정 생성하기
//   void _createSSHAccount(BuildContext context) async {
//     final userName = _userNameController.text;
//     final password = _passwordController.text;
//     final repoUrl = widget.repoUrl; // repoUrl은 이전 페이지에서 전달된 값

//     if (userName.isNotEmpty && password.isNotEmpty && repoUrl.isNotEmpty) {
//       try {
//         final response = await ApiService.addUser(userName, password, repoUrl);
//         if (response.statusCode == 200) {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(const SnackBar(content: Text('SSH 계정 생성 성공')));
//         } else {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(SnackBar(content: Text('Error: ${response.body}')));
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(const SnackBar(content: Text('SSH 계정 생성 실패')));
//       }
//     } else {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('모든 필드를 입력해주세요')));
//     }
//   }

//   // GitHub으로 이동
//   // GitHub으로 이동
//   void _goToGitHub() async {
//     final url = Uri.parse('https://github.com/BackOverflow/BackendArchive');
//     if (await canLaunchUrl(url)) {
//       await launchUrl(url); // launchUrl 사용
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Archive'),
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // 서버 정보 카드
//             Card(
//               elevation: 5,
//               margin: const EdgeInsets.only(bottom: 20),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       '🔍 서버 정보 카드',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     // 사용자 이름과 비밀번호를 입력하는 필드
//                     TextField(
//                       controller: _userNameController,
//                       decoration: const InputDecoration(labelText: '사용자 이름'),
//                     ),
//                     TextField(
//                       controller: _passwordController,
//                       obscureText: true,
//                       decoration: const InputDecoration(labelText: '비밀번호'),
//                     ),
//                     Text(
//                       '리포지토리 URL: ${widget.repoUrl}',
//                     ), // 이전 페이지에서 받은 repoUrl을 표시
//                   ],
//                 ),
//               ),
//             ),

//             // SSH 계정 생성하기 버튼
//             ElevatedButton(
//               onPressed: () => _createSSHAccount(context),
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//               child: const Text('SSH 계정 생성하기'),
//             ),

//             const SizedBox(height: 20),

//             // Archive Now 버튼
//             ElevatedButton(
//               onPressed: () => _pushToArchive(context),
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//               child: const Text('Archive Now'),
//             ),

//             const SizedBox(height: 20),

//             // Go to GitHub 버튼
//             ElevatedButton(
//               onPressed: _goToGitHub,
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
//               child: const Text('go to gitHub'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Archive Now 버튼 클릭 시 호출되는 메서드
//   void _pushToArchive(BuildContext context) async {
//     final userName = _userNameController.text;

//     if (userName.isNotEmpty) {
//       try {
//         final response = await ApiService.pushToArchive(userName);
//         if (response.statusCode == 200) {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(const SnackBar(content: Text('Push to Archive 성공')));
//         } else {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(SnackBar(content: Text('Error: ${response.body}')));
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(const SnackBar(content: Text('Push to Archive 실패')));
//       }
//     } else {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('사용자 이름을 입력해주세요')));
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'api_service.dart';
import 'package:url_launcher/url_launcher.dart'; // url_launcher 패키지 임포트

class ArchivePage extends StatefulWidget {
  final String token;
  final String repoUrl;
  final String username;

  const ArchivePage({
    super.key,
    required this.token,
    required this.repoUrl,
    required this.username,
  });

  @override
  _ArchivePageState createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  // final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // SSH 계정 생성하기
  void _createSSHAccount(BuildContext context) async {
    // final userName = _userNameController.text;
    final password = _passwordController.text;
    final repoUrl = widget.repoUrl; // repoUrl은 이전 페이지에서 전달된 값

    if (widget.username.isNotEmpty &&
        password.isNotEmpty &&
        repoUrl.isNotEmpty) {
      try {
        final response = await ApiService.addUser(
          widget.username,
          password,
          repoUrl,
        );
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('SSH 계정 생성 성공')));
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${response.body}')));
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('SSH 계정 생성 실패')));
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('모든 필드를 입력해주세요')));
    }
  }

  // GitHub으로 이동
  void _goToGitHub() async {
    final url = Uri.parse('https://github.com/BackOverflow/BackendArchive');
    if (await canLaunchUrl(url)) {
      await launchUrl(url); // launchUrl 사용
    } else {
      throw 'Could not launch $url';
    }
  }

  // Load Cloned Repo
  void _loadClonedRepo(BuildContext context) async {
    // final userName = _userNameController.text;
    final userRepoUrl = widget.repoUrl;

    print("userRepoUrl: $userRepoUrl");

    if (widget.username.isNotEmpty && userRepoUrl.isNotEmpty) {
      try {
        final response = await ApiService.loadClonedRepo(
          widget.username,
          userRepoUrl,
        );
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cloned Repo loaded successfully')),
          );
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${response.body}')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load cloned repo')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('사용자 이름과 리포지토리 URL을 입력해주세요')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Archive'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 서버 정보 카드
            Card(
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🔍 서버 정보 카드',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // 사용자 이름과 비밀번호를 입력하는 필드
                    Text(
                      'username: ${widget.username}',
                    ), // 이전 페이지에서 받은 repoUrl을 표시
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: '비밀번호'),
                    ),
                    Text(
                      '리포지토리 URL: ${widget.repoUrl}',
                    ), // 이전 페이지에서 받은 repoUrl을 표시
                  ],
                ),
              ),
            ),

            // SSH 계정 생성하기 버튼
            ElevatedButton(
              onPressed: () => _createSSHAccount(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('SSH 계정 생성하기'),
            ),

            const SizedBox(height: 20),

            // Archive Now 버튼
            ElevatedButton(
              onPressed: () => _pushToArchive(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Archive Now'),
            ),

            const SizedBox(height: 20),

            // Go to GitHub 버튼
            ElevatedButton(
              onPressed: _goToGitHub,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: const Text('Go to GitHub'),
            ),

            const SizedBox(height: 20),

            // Load Cloned Repo 버튼 추가
            ElevatedButton(
              onPressed: () => _loadClonedRepo(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Load Cloned Repo'),
            ),
          ],
        ),
      ),
    );
  }

  // Archive Now 버튼 클릭 시 호출되는 메서드
  void _pushToArchive(BuildContext context) async {
    // final userName = _userNameController.text;

    if (widget.username.isNotEmpty) {
      try {
        final response = await ApiService.pushToArchive(widget.username);
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Push to Archive 성공')));
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${response.body}')));
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Push to Archive 실패')));
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('사용자 이름을 입력해주세요')));
    }
  }
}
