// // import 'package:flutter/material.dart';
// // import 'api_service.dart'; // ApiService 임포트 (Git 클론 관련 함수)
// // import 'dart:convert';

// // class HomePage extends StatefulWidget {
// //   final String token; // 로그인 후 받은 토큰을 받아올 변수

// //   const HomePage({super.key, required this.token}); // 생성자를 통해 token을 전달받음

// //   @override
// //   _HomePageState createState() => _HomePageState();
// // }

// // class _HomePageState extends State<HomePage> {
// //   final TextEditingController repoUrlController =
// //       TextEditingController(); // Git URL 입력 받기 위한 컨트롤러
// //   String message = ''; // 서버 응답 메시지 저장 변수

// //   // Git 리포지토리 클론 함수
// //   void cloneRepo() async {
// //     final repoUrl = repoUrlController.text.trim(); // 입력된 URL 가져오기

// //     if (repoUrl.isEmpty) {
// //       setState(() {
// //         message = '리포지토리 URL을 입력해주세요.';
// //       });
// //       return;
// //     }

// //     // 받은 토큰을 로그로 출력
// //     print("Received Token: ${widget.token}");

// //     try {
// //       final response = await ApiService.cloneRepo(
// //         repoUrl,
// //         widget.token,
// //       ); // 토큰을 함께 넘겨서 클론 요청

// //       if (response.statusCode == 200) {
// //         setState(() {
// //           message = 'Git 리포지토리 클론 성공!';
// //         });
// //       } else {
// //         setState(() {
// //           message = 'Error: ${response.body}';
// //         });
// //       }
// //     } catch (e) {
// //       setState(() {
// //         message = 'Git 리포지토리 클론 중 오류가 발생했습니다. 오류: $e';
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Git 리포지토리 클론')),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             // Git 리포지토리 URL 입력 필드
// //             TextField(
// //               controller: repoUrlController,
// //               decoration: const InputDecoration(
// //                 labelText: 'Git Repository URL',
// //                 border: OutlineInputBorder(),
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             // 클론 버튼
// //             ElevatedButton(
// //               onPressed: cloneRepo,
// //               child: const Text('Clone Repository'),
// //             ),
// //             const SizedBox(height: 20),
// //             // 클론 성공/실패 메시지 표시
// //             Text(
// //               message,
// //               style: const TextStyle(fontSize: 16, color: Colors.black),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'api_service.dart'; // ApiService 임포트 (Git 클론 관련 함수)
// // import 'dart:convert';
// // import 'session_page.dart'; // SessionPage 임포트

// // class HomePage extends StatefulWidget {
// //   final String token; // 로그인 후 받은 토큰을 받아올 변수

// //   const HomePage({super.key, required this.token}); // 생성자를 통해 token을 전달받음

// //   @override
// //   _HomePageState createState() => _HomePageState();
// // }

// // class _HomePageState extends State<HomePage> {
// //   final TextEditingController repoUrlController =
// //       TextEditingController(); // Git URL 입력 받기 위한 컨트롤러
// //   String message = ''; // 서버 응답 메시지 저장 변수

// //   // Git 리포지토리 클론 함수
// //   void cloneRepo() async {
// //     final repoUrl = repoUrlController.text.trim(); // 입력된 URL 가져오기

// //     if (repoUrl.isEmpty) {
// //       setState(() {
// //         message = '리포지토리 URL을 입력해주세요.';
// //       });
// //       return;
// //     }

// //     // 받은 토큰을 로그로 출력
// //     print("Received Token: ${widget.token}");

// //     try {
// //       final response = await ApiService.cloneRepo(
// //         repoUrl,
// //         widget.token,
// //       ); // 토큰을 함께 넘겨서 클론 요청

// //       if (response.statusCode == 200) {
// //         setState(() {
// //           message = 'Git 리포지토리 클론 성공!';
// //         });

// //         // Git 클론이 성공적으로 완료되면 session_page로 이동
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //             builder: (context) => SessionPage(
// //               token: widget.token,
// //               repoUrl: repoUrl, // repoUrl 전달
// //             ),
// //           ),
// //         );
// //       } else {
// //         setState(() {
// //           message = 'Error: ${response.body}';
// //         });
// //       }
// //     } catch (e) {
// //       setState(() {
// //         message = 'Git 리포지토리 클론 중 오류가 발생했습니다. 오류: $e';
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Git 리포지토리 클론')),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             // Git 리포지토리 URL 입력 필드
// //             TextField(
// //               controller: repoUrlController,
// //               decoration: const InputDecoration(
// //                 labelText: 'Git Repository URL',
// //                 border: OutlineInputBorder(),
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             // 클론 버튼
// //             ElevatedButton(
// //               onPressed: cloneRepo,
// //               child: const Text('Clone Repository'),
// //             ),
// //             const SizedBox(height: 20),
// //             // 클론 성공/실패 메시지 표시
// //             Text(
// //               message,
// //               style: const TextStyle(fontSize: 16, color: Colors.black),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

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
//   List<dynamic> clonedRepos = []; // 클론된 레포 목록 저장
//   bool isLoadingRepos = true; // 로딩 상태
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

//   void fetchClonedRepos() async {
//     setState(() {
//       isLoadingRepos = true;
//     });

//     try {
//       final response = await ApiService.getUserId(widget.token);
//       if (response.statusCode == 200) {
//         final userData = jsonDecode(response.body);
//         final userId = userData['userId'];

//         final cloneResponse = await ApiService.getCloneRepo(
//           widget.token,
//           userId,
//         );
//         if (cloneResponse.statusCode == 200) {
//           final responseData = jsonDecode(cloneResponse.body);
//           setState(() {
//             clonedRepos = responseData['clonedRepos']; // <- 구조 반영
//             isLoadingRepos = false;
//           });
//         } else {
//           setState(() {
//             message = 'Failed to fetch cloned repos.';
//             isLoadingRepos = false;
//           });
//         }
//       }
//     } catch (e) {
//       setState(() {
//         message = 'Error fetching cloned repos: $e';
//         isLoadingRepos = false;
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchClonedRepos();
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
import 'api_service.dart'; // ApiService 임포트
import 'dart:convert';
import 'session_page.dart'; // SessionPage 임포트

class HomePage extends StatefulWidget {
  final String token;

  const HomePage({super.key, required this.token});

  @override
  _HomePageState createState() => _HomePageState();
}

enum WhaleState { idle, loading, success }

class _HomePageState extends State<HomePage> {
  final TextEditingController repoUrlController = TextEditingController();
  String message = '';
  List<dynamic> clonedRepos = [];
  bool isLoadingRepos = true;
  WhaleState whaleState = WhaleState.idle;

  @override
  void initState() {
    super.initState();
    fetchClonedRepos();
  }

  void cloneRepo() async {
    final repoUrl = repoUrlController.text.trim();

    if (repoUrl.isEmpty) {
      setState(() {
        message = '리포지토리 URL을 입력해주세요.';
      });
      return;
    }

    print("Received Token: ${widget.token}");

    setState(() {
      whaleState = WhaleState.loading;
    });

    try {
      final response = await ApiService.cloneRepo(repoUrl, widget.token);

      if (response.statusCode == 200) {
        setState(() {
          message = 'Git 리포지토리 클론 성공!';
          whaleState = WhaleState.success;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SessionPage(token: widget.token, repoUrl: repoUrl),
          ),
        );
      } else {
        setState(() {
          message = 'Error: ${response.body}';
          whaleState = WhaleState.idle;
        });
      }
    } catch (e) {
      setState(() {
        message = 'Git 리포지토리 클론 중 오류가 발생했습니다. 오류: $e';
        whaleState = WhaleState.idle;
      });
    }
  }

  void fetchClonedRepos() async {
    setState(() {
      isLoadingRepos = true;
    });

    try {
      final response = await ApiService.getUserId(widget.token);
      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        final userId = userData['userId'];

        final cloneResponse = await ApiService.getCloneRepo(
          widget.token,
          userId,
        );

        if (cloneResponse.statusCode == 200) {
          final responseData = jsonDecode(cloneResponse.body);
          setState(() {
            clonedRepos = List<String>.from(responseData['clonedRepos']);
            isLoadingRepos = false;
          });
        } else {
          setState(() {
            message = 'Failed to fetch cloned repos.';
            isLoadingRepos = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        message = 'Error fetching cloned repos: $e';
        isLoadingRepos = false;
      });
    }
  }

  // ✅ Whale animation widget
  Widget whaleWidget() {
    switch (whaleState) {
      case WhaleState.idle:
        return const Text('🐳', style: TextStyle(fontSize: 80));
      case WhaleState.loading:
        return const Text('🐋', style: TextStyle(fontSize: 80));
      case WhaleState.success:
        return const Text('🐳💦', style: TextStyle(fontSize: 80));
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
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Back button + title row
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'clone git repository',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Whale Emoji / Animation
                  whaleWidget(),

                  const SizedBox(height: 24),

                  // Input for repo URL
                  TextField(
                    controller: repoUrlController,
                    decoration: const InputDecoration(
                      labelText: 'git repository url',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Clone Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: cloneRepo,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'clone repository',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Error / Success message
                  if (message.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        message,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),

                  const SizedBox(height: 24),

                  // Cloned Repos title
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'cloned repositories',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // List of Cloned Repos
                  SizedBox(
                    height: 300,
                    child: isLoadingRepos
                        ? const Center(child: CircularProgressIndicator())
                        : clonedRepos.isEmpty
                        ? const Center(
                            child: Text('no repositories cloned yet.'),
                          )
                        : ListView.builder(
                            itemCount: clonedRepos.length,
                            itemBuilder: (context, index) {
                              final url = clonedRepos[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 4,
                                ),
                                child: ListTile(
                                  title: Text(url),
                                  trailing: ElevatedButton(
                                    child: const Text('open'),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SessionPage(
                                            token: widget.token,
                                            repoUrl: url,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                  ),

                  const SizedBox(height: 24),

                  // Footer
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
