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

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'api_service.dart';
import 'session_page.dart';
import 'warning_page.dart';
import 'archive_page.dart';
import 'search_page.dart';
import 'community_page.dart';

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
  String? userId;

  late VideoPlayerController _videoController;
  bool _videoInitialized = false;

  @override
  void initState() {
    super.initState();
    loadUserIdAndRepos();
    _initializeVideo();
  }

  Future<void> loadUserIdAndRepos() async {
    setState(() {
      isLoadingRepos = true;
    });

    try {
      final response = await ApiService.getUserId(widget.token);
      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        setState(() {
          userId = userData['userId'];
        });

        await fetchClonedRepos(userData['userId']);
      } else {
        setState(() {
          message = 'Failed to get user ID: ${response.body}';
          isLoadingRepos = false;
        });
      }
    } catch (e) {
      setState(() {
        message = 'Error retrieving user ID: $e';
        isLoadingRepos = false;
      });
    }
  }

  Future<void> fetchClonedRepos(String userId) async {
    try {
      final cloneResponse = await ApiService.getCloneRepo(widget.token, userId);
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
    } catch (e) {
      setState(() {
        message = 'Error fetching cloned repos: $e';
        isLoadingRepos = false;
      });
    }
  }

  Future<void> _initializeVideo() async {
    _videoController = VideoPlayerController.asset('assets/videos/whale.mp4');
    await _videoController.initialize();
    _videoController.setLooping(true);
    setState(() {
      _videoInitialized = true;
    });
    _pauseVideo();
  }

  @override
  void dispose() {
    repoUrlController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  void _playVideo() {
    if (_videoInitialized && !_videoController.value.isPlaying) {
      _videoController.play();
    }
  }

  void _pauseVideo() {
    if (_videoInitialized && _videoController.value.isPlaying) {
      _videoController.pause();
    }
  }

  void _setWhaleState(WhaleState state) {
    setState(() {
      whaleState = state;
    });
    if (state == WhaleState.loading) {
      _playVideo();
    } else {
      _pauseVideo();
    }
  }

  void cloneRepo() async {
    final repoUrl = repoUrlController.text.trim();
    if (repoUrl.isEmpty) {
      setState(() {
        message = 'Please enter a repository URL.';
      });
      return;
    }

    _setWhaleState(WhaleState.loading);

    try {
      final response = await ApiService.cloneRepo(repoUrl, widget.token);

      if (response.statusCode == 200) {
        setState(() {
          message = 'Repository cloned successfully!';
        });
        _setWhaleState(WhaleState.idle);

        // ✅ 새로고침 추가
        if (userId != null) {
          await fetchClonedRepos(userId!);
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SessionPage(token: widget.token, repoUrl: repoUrl),
          ),
        ).then((_) {
          _setWhaleState(WhaleState.idle);

          // ✅ 다시 새로고침 (돌아왔을 때도 반영)
          if (userId != null) {
            fetchClonedRepos(userId!);
          }
        });
      } else {
        setState(() {
          message = 'Error: ${response.body}';
        });
        _setWhaleState(WhaleState.idle);
      }
    } catch (e) {
      setState(() {
        message = 'Error cloning repository: $e';
        _setWhaleState(WhaleState.idle);
      });
    }
  }

  Widget whaleVideoWidget() {
    if (!_videoInitialized) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      width: 200,
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: VideoPlayer(_videoController),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Clone Git Repository',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Text('‼️', style: TextStyle(fontSize: 24)),
            tooltip: 'Warnings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WarningPage()),
              );
            },
          ),
          IconButton(
            icon: const Text('👥', style: TextStyle(fontSize: 24)),
            tooltip: 'Community',
            onPressed: () {
              if (userId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Loading user info. Please wait...'),
                  ),
                );
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CommunityPage(token: widget.token, userId: userId!),
                ),
              );
            },
          ),
        ],
      ),
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
                  whaleVideoWidget(),
                  const SizedBox(height: 24),
                  TextField(
                    controller: repoUrlController,
                    decoration: const InputDecoration(
                      labelText: 'https://github.com/...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                        'Clone Repository',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (message.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        message,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),
                  const SizedBox(height: 24),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Cloned Repositories',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 300,
                    child: isLoadingRepos
                        ? const Center(child: CircularProgressIndicator())
                        : clonedRepos.isEmpty
                        ? const Center(
                            child: Text('No repositories cloned yet.'),
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
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Text(
                                          '📦',
                                          style: TextStyle(fontSize: 24),
                                        ),
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
                                      const SizedBox(width: 8),
                                      IconButton(
                                        icon: const Text(
                                          '📨',
                                          style: TextStyle(fontSize: 24),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ArchivePage(
                                                token: widget.token,
                                                repoUrl: url,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
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
      floatingActionButton: FloatingActionButton(
        tooltip: 'Help / Search',
        child: const Icon(Icons.help_outline),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SearchPage()),
          );
        },
      ),
    );
  }
}
