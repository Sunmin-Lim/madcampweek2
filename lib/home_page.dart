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

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'api_service.dart';
// import 'session_page.dart';
// import 'warning_page.dart';
// import 'community_page.dart';
// import 'archive_page.dart';
// import 'logout_page.dart';
// import 'socket_service.dart';
// import 'package:provider/provider.dart';

// class HomePage extends StatefulWidget {
//   final String token;
//   // final String userId;
//   // final SocketService socketService;

//   // const HomePage({super.key, required this.token, required this.socketService, required this.userId});
//   const HomePage({super.key, required this.token});

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// enum WhaleState { idle, loading, success }

// class _HomePageState extends State<HomePage> {
//   final TextEditingController repoUrlController = TextEditingController();
//   String message = '';
//   List<dynamic> clonedRepos = [];
//   bool isLoadingRepos = true;
//   WhaleState whaleState = WhaleState.idle;

//   late VideoPlayerController _videoController;
//   bool _videoInitialized = false;

//   @override
//   void initState() {
//     super.initState();

//     fetchClonedRepos();
//     _initializeVideo();
//   }

//   Future<void> _initializeVideo() async {
//     _videoController = VideoPlayerController.asset('assets/videos/whale.mp4');
//     await _videoController.initialize();
//     _videoController.setLooping(true);
//     setState(() {
//       _videoInitialized = true;
//     });
//     _pauseVideo(); // Start paused
//   }

//   @override
//   void dispose() {
//     repoUrlController.dispose();
//     _videoController.dispose();
//     super.dispose();
//   }

//   void _playVideo() {
//     if (_videoInitialized && !_videoController.value.isPlaying) {
//       _videoController.play();
//     }
//   }

//   void _pauseVideo() {
//     if (_videoInitialized && _videoController.value.isPlaying) {
//       _videoController.pause();
//     }
//   }

//   void _setWhaleState(WhaleState state) {
//     setState(() {
//       whaleState = state;
//     });
//     if (state == WhaleState.loading) {
//       _playVideo();
//     } else {
//       _pauseVideo();
//     }
//   }

//   void cloneRepo() async {
//     final repoUrl = repoUrlController.text.trim();

//     if (repoUrl.isEmpty) {
//       setState(() {
//         message = 'Please enter a repository URL.';
//       });
//       return;
//     }

//     _setWhaleState(WhaleState.loading);

//     try {
//       final response = await ApiService.cloneRepo(repoUrl, widget.token);

//       if (response.statusCode == 200) {
//         setState(() {
//           message = 'Repository cloned successfully!';
//         });
//         _setWhaleState(WhaleState.idle); // pause after success

//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) =>
//                 SessionPage(token: widget.token, repoUrl: repoUrl),
//           ),
//         ).then((_) {
//           _setWhaleState(WhaleState.idle);
//         });
//       } else {
//         setState(() {
//           message = 'Error: ${response.body}';
//         });
//         _setWhaleState(WhaleState.idle);
//       }
//     } catch (e) {
//       setState(() {
//         message = 'Error cloning repository: $e';
//       });
//       _setWhaleState(WhaleState.idle);
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
//             clonedRepos = List<String>.from(responseData['clonedRepos']);
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

//   Widget whaleVideoWidget() {
//     if (!_videoInitialized) {
//       return const SizedBox(
//         height: 200,
//         child: Center(child: CircularProgressIndicator()),
//       );
//     }

//     return SizedBox(
//       width: 200,
//       height: 200,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(16),
//         child: VideoPlayer(_videoController),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => LogoutPage(token: widget.token)),
//         );
//         return false; // 기본 back 동작 막음
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 24.0,
//                   vertical: 16.0,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     // Top Bar with Back, Title, and Emojis
//                     Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(
//                             Icons.arrow_back,
//                             color: Colors.black,
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => LogoutPage(token: widget.token),
//                               ),
//                             );
//                           },
//                         ),
//                         const SizedBox(width: 8),
//                         const Text(
//                           'Clone Git Repository',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black,
//                           ),
//                         ),
//                         const Spacer(),
//                         IconButton(
//                           icon: const Text(
//                             '⚠️',
//                             style: TextStyle(fontSize: 24),
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => WarningPage(),
//                               ),
//                             );
//                           },
//                         ),
//                         IconButton(
//                           icon: const Text(
//                             '👥',
//                             style: TextStyle(fontSize: 24),
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const CommunityPage(),
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 24),

//                     // Whale Video
//                     whaleVideoWidget(),

//                     const SizedBox(height: 24),

//                     // Input for repo URL
//                     TextField(
//                       controller: repoUrlController,
//                       decoration: const InputDecoration(
//                         labelText: 'https://github.com/...',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),

//                     const SizedBox(height: 16),

//                     // Clone Button
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: cloneRepo,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.lightBlue,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: const Text(
//                           'Clone Repository',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 16),

//                     // Error / Success Message
//                     if (message.isNotEmpty)
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8.0),
//                         child: Text(
//                           message,
//                           style: const TextStyle(
//                             color: Colors.red,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ),

//                     const SizedBox(height: 24),

//                     // Cloned Repos Title
//                     const Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         'Cloned Repositories',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.normal,
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     // List of Cloned Repos
//                     SizedBox(
//                       height: 300,
//                       child: isLoadingRepos
//                           ? const Center(child: CircularProgressIndicator())
//                           : clonedRepos.isEmpty
//                           ? const Center(
//                               child: Text('No repositories cloned yet.'),
//                             )
//                           : ListView.builder(
//                               itemCount: clonedRepos.length,
//                               itemBuilder: (context, index) {
//                                 final url = clonedRepos[index];
//                                 return Card(
//                                   margin: const EdgeInsets.symmetric(
//                                     vertical: 6,
//                                     horizontal: 4,
//                                   ),
//                                   child: ListTile(
//                                     title: Text(url),
//                                     trailing: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         IconButton(
//                                           icon: const Text(
//                                             '📦',
//                                             style: TextStyle(fontSize: 24),
//                                           ),
//                                           onPressed: () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     SessionPage(
//                                                       token: widget.token,
//                                                       repoUrl: url,
//                                                     ),
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                         const SizedBox(width: 8),
//                                         IconButton(
//                                           icon: const Text(
//                                             '📨',
//                                             style: TextStyle(fontSize: 24),
//                                           ),
//                                           onPressed: () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     ArchivePage(
//                                                       token: widget.token,
//                                                       repoUrl: url,
//                                                     ),
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                     ),

//                     const SizedBox(height: 24),

//                     Text(
//                       'BackOverFlow 2025',
//                       style: TextStyle(
//                         color: Colors.grey.shade500,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
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
import 'community_page.dart';
import 'archive_page.dart';
import 'logout_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final String token;
  final String username;

  const HomePage({super.key, required this.token, required this.username});

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

  late VideoPlayerController _videoController;
  bool _videoInitialized = false;

  @override
  void initState() {
    super.initState();
    fetchClonedRepos();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _videoController = VideoPlayerController.asset('assets/videos/whale.mp4');
    await _videoController.initialize();
    _videoController.setLooping(true);
    setState(() {
      _videoInitialized = true;
    });
    _pauseVideo(); // Start paused
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
    } catch (e) {
      setState(() {
        message = 'Error cloning repository: $e';
      });
      _setWhaleState(WhaleState.idle);
    }
  }

  // void fetchClonedRepos() async {
  //   setState(() {
  //     isLoadingRepos = true;
  //   });

  //   try {
  //     final response = await ApiService.getUserId(widget.token);

  //     if (response.statusCode == 200) {
  //       setState(() {
  //         message = 'Repository cloned successfully!';
  //       });
  //       _setWhaleState(WhaleState.idle); // pause after success

  //       // 클론이 성공했으면 레포지토리 목록을 새로 고침
  //       fetchClonedRepos(); // 클론된 리포지토리 목록을 새로 고침하는 함수 호출
  //     } else {
  //       setState(() {
  //         message = 'Error: ${response.body}';
  //       });
  //       _setWhaleState(WhaleState.idle);
  //     }
  //   } catch (e) {
  //     setState(() {
  //       message = 'Error fetching cloned repos: $e';
  //       isLoadingRepos = false;
  //     });
  //   }
  // }

  void fetchClonedRepos() async {
    setState(() {
      isLoadingRepos = true; // 로딩 시작
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
            isLoadingRepos = false; // 로딩 종료
          });
        } else {
          setState(() {
            message = 'Failed to fetch cloned repos.';
            isLoadingRepos = false; // 로딩 종료
          });
        }
      } else {
        setState(() {
          message = 'Error: ${response.body}';
          isLoadingRepos = false; // 로딩 종료
        });
      }
    } catch (e) {
      setState(() {
        message = 'Error fetching cloned repos: $e';
        isLoadingRepos = false; // 로딩 종료
      });
    }
  }

  void refreshRepos() {
    fetchClonedRepos(); // 새로고침을 위한 데이터 갱신
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => LogoutPage(token: widget.token)),
        );
        return false; // 기본 back 동작 막음
      },
      child: Scaffold(
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
                    // Top Bar with Back, Title, and Emojis
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LogoutPage(token: widget.token),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Clone Git Repository',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Text(
                            '⚠️',
                            style: TextStyle(fontSize: 24),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WarningPage(),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Text(
                            '👥',
                            style: TextStyle(fontSize: 24),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CommunityPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Whale Video
                    whaleVideoWidget(),

                    const SizedBox(height: 24),

                    // Input for repo URL
                    TextField(
                      controller: repoUrlController,
                      decoration: const InputDecoration(
                        labelText: 'https://github.com/...',
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
                          'Clone Repository',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Error / Success Message
                    if (message.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          message,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                      ),

                    const SizedBox(height: 24),

                    // Cloned Repos Title
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Cloned Repositories',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
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
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) => SessionPage(
                                            //       token: widget.token,
                                            //       repoUrl: url, // 전달되는 repoUrl
                                            //       imageName:
                                            //           '${widget.username}-${url.split('/').last.replaceAll('.git', '')}', // 이미지 이름 생성
                                            //     ),
                                            //   ),
                                            // ).then((_) {
                                            //   setState(() {
                                            //     // 페이지를 돌아왔을 때 URL을 갱신하거나 업데이트할 작업을 수행

                                            //     fetchClonedRepos();
                                            //   });
                                            // });
                                            // 고유한 이미지 이름 생성 (username과 repoUrl을 조합)
                                            String repoName = url
                                                .split('/')
                                                .last
                                                .replaceAll(
                                                  '.git',
                                                  '',
                                                ); // URL에서 레포 이름 추출
                                            String imageName =
                                                '${widget.username}-${repoName}'; // username + repoName 결합

                                            // 로그로 imageName 확인
                                            print(
                                              'Generated imageName: $imageName',
                                            );

                                            // Navigator.push로 이동
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => SessionPage(
                                                  token: widget.token,
                                                  repoUrl: url, // 전달되는 repoUrl
                                                  imageName:
                                                      imageName, // 생성된 이미지 이름 전달
                                                ),
                                              ),
                                            ).then((_) {
                                              // 페이지가 돌아온 후 URL을 갱신하거나 업데이트할 작업을 수행
                                              setState(() {
                                                fetchClonedRepos(); // 페이지를 돌아왔을 때 URL을 갱신
                                              });
                                            });
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
                                                builder: (context) =>
                                                    ArchivePage(
                                                      token: widget.token,
                                                      repoUrl:
                                                          url, // 전달되는 repoUrl,
                                                    ),
                                              ),
                                            ).then((_) {
                                              setState(() {
                                                // 페이지를 돌아왔을 때 URL을 갱신하거나 업데이트할 작업을 수행
                                                fetchClonedRepos();
                                              });
                                            });
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

                    // Refresh Button
                    ElevatedButton(
                      onPressed: refreshRepos,
                      child: const Text('Refresh Cloned Repos'),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      'BackOverFlow 2025',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
