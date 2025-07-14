// import 'package:flutter/material.dart';
// import 'api_service.dart'; // ApiService 임포트 (Docker 빌드 관련 함수)
// import 'dart:convert';

// class SessionPage extends StatefulWidget {
//   final String token;
//   final String repoUrl;

//   const SessionPage({super.key, required this.token, required this.repoUrl});

//   @override
//   _SessionPageState createState() => _SessionPageState();
// }

// class _SessionPageState extends State<SessionPage> {
//   String message = ''; // 서버 응답 메시지 저장 변수

//   // Docker 빌드에 필요한 값들
//   late String userId; // userId를 동적으로 설정
//   late String username;
//   late String localPath;
//   String basePath =
//       '/home/hanjeongjin/Workspace_ubuntu/backend/madcampweek2-backend/F:/workspace/server_manage/home';
//   String imageName = 'custom-image-name'; // 임의로 설정한 imageName
//   String cpu = '0.5'; // 임의로 설정한 CPU 리소스
//   String memory = '200MB'; // 임의로 설정한 메모리 리소스
//   String port = '8080:80';

//   bool isLoading = true; // userId를 가져오는 동안 로딩 상태 관리

//   // userId를 API에서 가져오는 함수 (username도 함께 받기)
//   Future<void> getUserInfo() async {
//     try {
//       final response = await ApiService.getUserId(
//         widget.token,
//       ); // getUser API 호출
//       if (response.statusCode == 200) {
//         final userData = jsonDecode(response.body); // JSON으로 변환된 사용자 데이터
//         setState(() {
//           userId = userData['userId']; // userId 추출
//           username = userData['username']; // username 추출
//           String repoName = widget.repoUrl
//               .split('/')
//               .last
//               .replaceAll('.git', ''); // repoName 추출
//           localPath = '$basePath/$username/$repoName'; // 동적으로 localPath 설정
//           isLoading = false; // 로딩 완료
//         });
//       } else {
//         setState(() {
//           message = 'Error: ${response.body}';
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         message = 'Error retrieving user info: $e';
//         isLoading = false;
//       });
//     }
//   }

//   // Docker 빌드 함수
//   void buildDockerContainer() async {
//     if (isLoading) {
//       setState(() {
//         message = 'Loading user data...';
//       });
//       return;
//     }

//     // userId가 로드되었을 때만 Docker 빌드를 진행하도록 함
//     if (userId.isEmpty) {
//       setState(() {
//         message = 'User ID is not available.';
//       });
//       return;
//     }

//     setState(() {
//       message = 'Docker 빌드 중...';
//     });

//     try {
//       final response = await ApiService.dockerBuild(
//         widget.token,
//         userId, // 동적으로 설정된 userId 사용
//         localPath, // 임의로 설정된 localPath 사용
//         imageName, // 임의로 설정된 imageName 사용
//       ); // Docker 빌드 요청

//       if (response.statusCode == 200) {
//         setState(() {
//           message = 'Docker 빌드 성공!';
//         });
//       } else {
//         setState(() {
//           message = 'Docker 빌드 실패: ${response.body}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         message = 'Docker 빌드 중 오류 발생: $e';
//       });
//     }
//   }

//   // Docker 실행 함수
//   void runDockerContainer() async {
//     if (isLoading) {
//       setState(() {
//         message = 'Loading user data...'; // 데이터 로딩 중 메시지
//       });
//       return;
//     }

//     // userId가 로드되었을 때만 Docker 실행을 진행하도록 함
//     if (userId.isEmpty) {
//       setState(() {
//         message = 'User ID is not available.';
//       });
//       return;
//     }

//     try {
//       // 1. 세션을 가져오기 위한 API 호출
//       final sessionResponse = await ApiService.getSession(widget.token, userId);
//       if (sessionResponse.statusCode == 200) {
//         final sessionData = jsonDecode(sessionResponse.body);

//         // sessionData가 배열이므로 첫 번째 세션 객체에서 sessionId 추출
//         final sessionId = sessionData[0]['_id']; // 배열에서 첫 번째 객체의 sessionId 추출

//         // 2. Docker 컨테이너 실행 요청
//         final response = await ApiService.dockerRun(
//           widget.token,
//           sessionId,
//           cpu,
//           memory,
//           port,
//         );

//         // 3. 실행 결과 처리
//         if (response.statusCode == 200) {
//           final responseData = jsonDecode(response.body);
//           // Docker 실행이 성공적으로 되면, response에서 반환된 포트 정보 추출
//           String mappedPort = responseData['port']; // API 응답에서 포트 번호 추출
//           String backendServerUrl = 'http://143.248.183.61'; // 여기를 실제 서버 주소로 설정
//           String fullUrl = '$backendServerUrl:$mappedPort'; // 포트 번호와 URL을 결합

//           setState(() {
//             message = 'Docker container 실행 성공! 백엔드 URL: $fullUrl';
//           });
//         } else {
//           setState(() {
//             message = 'Docker container 실행 실패: ${response.body}';
//           });
//         }
//       } else {
//         setState(() {
//           message = '세션 조회 실패: ${sessionResponse.body}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         message = '컨테이너 실행 중 오류 발생: $e'; // 실행 관련 에러 메시지
//       });
//     }
//   }

//   // Stop container 함수
//   void stopContainer() async {
//     try {
//       final sessionResponse = await ApiService.getSession(widget.token, userId);
//       if (sessionResponse.statusCode == 200) {
//         final sessionData = jsonDecode(sessionResponse.body);
//         final sessionId = sessionData[0]['_id'];
//         final containerId = sessionData[0]['container_id'];

//         final stopResponse = await ApiService.stopContainer(
//           widget.token,
//           containerId,
//           sessionId,
//         );

//         if (stopResponse.statusCode == 200) {
//           setState(() {
//             message = 'Container stopped successfully!';
//           });
//         } else {
//           setState(() {
//             message = 'Failed to stop container: ${stopResponse.body}';
//           });
//         }
//       }
//     } catch (e) {
//       setState(() {
//         message = 'Error stopping container: $e';
//       });
//     }
//   }

//   // Remove container 함수
//   void removeDockerContainer() async {
//     if (isLoading) {
//       setState(() {
//         message = 'Loading user data...'; // 데이터 로딩 중 메시지
//       });
//       return;
//     }

//     // userId가 로드되었을 때만 Docker 실행을 진행하도록 함
//     if (userId.isEmpty) {
//       setState(() {
//         message = 'User ID is not available.';
//       });
//       return;
//     }

//     try {
//       // 1. 세션을 가져오기 위한 API 호출
//       final sessionResponse = await ApiService.getSession(widget.token, userId);
//       if (sessionResponse.statusCode == 200) {
//         final sessionData = jsonDecode(sessionResponse.body);

//         // sessionData가 배열이므로 첫 번째 세션 객체에서 sessionId 추출
//         final sessionId = sessionData[0]['_id']; // 배열에서 첫 번째 객체의 sessionId 추출
//         final containerId = sessionData[0]['container_id']; // 컨테이너 ID 추출

//         // 2. Docker 컨테이너 삭제 요청
//         final response = await ApiService.removeContainer(
//           containerId,
//           widget.token,
//         );

//         // 3. 실행 결과 처리
//         if (response.statusCode == 200) {
//           setState(() {
//             message = 'Docker container removed successfully!';
//           });
//         } else {
//           setState(() {
//             message = 'Docker container removal failed: ${response.body}';
//           });
//         }
//       } else {
//         setState(() {
//           message = 'Session not found: ${sessionResponse.body}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         message = 'Error removing container: $e';
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getUserInfo(); // 페이지가 로드될 때 userId를 가져오는 함수 호출
//   }

//   @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(title: const Text('Docker 빌드 및 실행')),
//   //     body: Padding(
//   //       padding: const EdgeInsets.all(16.0),
//   //       child: Column(
//   //         mainAxisAlignment: MainAxisAlignment.center,
//   //         children: [
//   //           isLoading
//   //               ? const CircularProgressIndicator()
//   //               : Column(
//   //                   children: [
//   //                     ElevatedButton(
//   //                       onPressed: buildDockerContainer,
//   //                       child: const Text('Build Docker Image'),
//   //                     ),
//   //                     const SizedBox(height: 20),
//   //                     ElevatedButton(
//   //                       onPressed: runDockerContainer,
//   //                       child: const Text('Run Docker Container'),
//   //                     ),
//   //                     const SizedBox(height: 20),
//   //                     ElevatedButton(
//   //                       onPressed: stopContainer,
//   //                       child: const Text('Stop Container'),
//   //                     ),
//   //                   ],
//   //                 ),
//   //           const SizedBox(height: 20),
//   //           Text(
//   //             message,
//   //             style: const TextStyle(fontSize: 16, color: Colors.black),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Docker 빌드 및 실행')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             isLoading
//                 ? const CircularProgressIndicator()
//                 : Column(
//                     children: [
//                       ElevatedButton(
//                         onPressed: buildDockerContainer,
//                         child: const Text('Build Docker Image'),
//                       ),
//                       const SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: runDockerContainer,
//                         child: const Text('Run Docker Container'),
//                       ),
//                       const SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: stopContainer,
//                         child: const Text('Stop Container'),
//                       ),
//                       const SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: removeDockerContainer,
//                         child: const Text('Remove Docker Container'),
//                       ),
//                     ],
//                   ),
//             const SizedBox(height: 20),
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
import 'api_service.dart';

class SessionPage extends StatefulWidget {
  final String token;
  final String repoUrl;

  const SessionPage({super.key, required this.token, required this.repoUrl});

  @override
  _SessionPageState createState() => _SessionPageState();
}

enum WhaleState { idle, building, running, stopping, deleting }

class _SessionPageState extends State<SessionPage> {
  String message = '';
  bool isLoading = true;
  late String userId;
  late String username;
  late String localPath;

  String basePath =
      '/Users/imsnmn/madcampweek2-backend/F:/workspace/server_manage/home';
  String imageName = 'custom-image-name';

  final cpuController = TextEditingController(text: '0.5');
  final memoryController = TextEditingController(text: '200MB');
  final portController = TextEditingController(text: '8080:80');

  WhaleState whaleState = WhaleState.idle;

  // Animation state
  bool hasBox = false;
  bool showBeach = false;
  bool boxOpen = false;
  bool confettiVisible = false;
  double whalePosition = 0.0;
  double boxSize = 30;

  // Confetti animation
  double confettiScale = 1.0;
  double confettiOpacity = 1.0;
  double confettiOffsetY = 0.0;

  // Whale movement
  Timer? whaleMoveTimer;
  String whaleEmoji = '🐳';

  @override
  void initState() {
    super.initState();
    getUserInfo();
    startWhaleAnimation();
  }

  @override
  void dispose() {
    whaleMoveTimer?.cancel();
    super.dispose();
  }

  void startWhaleAnimation() {
    whaleMoveTimer?.cancel();
    whaleMoveTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (whalePosition >= 0.9) {
          whalePosition = -0.9;
        } else {
          whalePosition += 0.45;
        }
      });
    });
  }

  Widget whaleAndBox() {
    String boxEmoji = boxOpen ? '📤' : '📦';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasBox) Text(boxEmoji, style: TextStyle(fontSize: boxSize)),
        if (hasBox) const SizedBox(width: 6),
        Text(whaleEmoji, style: const TextStyle(fontSize: 50)),
      ],
    );
  }

  Widget whaleWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 200,
        width: double.infinity,
        child: Stack(
          children: [
            // Ocean background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlue.shade200, Colors.blue.shade800],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            // Beach
            AnimatedOpacity(
              opacity: showBeach ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text('🏝️', style: const TextStyle(fontSize: 80)),
                ),
              ),
            ),

            // Confetti
            if (confettiVisible)
              Align(
                alignment: Alignment(0, -0.5 + confettiOffsetY),
                child: Opacity(
                  opacity: confettiOpacity,
                  child: Transform.scale(
                    scale: confettiScale,
                    child: Text(
                      '🎉🎊🎉🎊',
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              ),

            // Whale + Box movement
            AnimatedAlign(
              alignment: Alignment(whalePosition, 0.4),
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              child: whaleAndBox(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getUserInfo() async {
    try {
      final response = await ApiService.getUserId(widget.token);
      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        setState(() {
          userId = userData['userId'];
          username = userData['username'];
          localPath =
              '$basePath/$username/${widget.repoUrl.split('/').last.replaceAll('.git', '')}';
          isLoading = false;
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

  Future<void> buildDockerContainer() async {
    if (isLoading) return;
    setWhaleState(WhaleState.building);
    setState(() {
      message = 'Docker 빌드 중...';
      hasBox = false;
      whalePosition = 0;
      showBeach = true;
      boxOpen = false;
      confettiVisible = false;
      boxSize = 30;
    });

    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      whalePosition = -1;
    });

    await Future.delayed(const Duration(seconds: 1));
    final success = await fakeBuildResult();

    if (success) {
      setState(() {
        whaleEmoji = '🐳💦'; // ✅ 빌드 성공 → 물 뿜기
        hasBox = true;
        whalePosition = 0;
        message = 'Docker 빌드 성공!';
      });
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        whaleEmoji = '🐳'; // ✅ 다시 🐳
      });
    } else {
      setState(() {
        hasBox = false;
        whalePosition = 0;
        message = 'Docker 빌드 실패!';
      });
    }

    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      showBeach = false;
    });

    setWhaleState(WhaleState.idle);
  }

  Future<void> runDockerContainer() async {
    if (isLoading) return;
    setWhaleState(WhaleState.running);
    setState(() {
      message = '컨테이너 실행 중...';
      whalePosition = 0;
      hasBox = true;
      boxOpen = false;
      confettiVisible = false;
      boxSize = 30;
    });

    await Future.delayed(const Duration(seconds: 1));
    final success = await fakeRunResult();

    setState(() {
      if (success) {
        boxOpen = true;
        confettiVisible = true;
        confettiScale = 1.0;
        confettiOpacity = 1.0;
        confettiOffsetY = 0.0;
        boxSize = 80;
        message = '컨테이너 실행 성공!';
      } else {
        boxOpen = false;
        confettiVisible = false;
        boxSize = 30;
        message = '컨테이너 실행 실패!';
      }
    });
  }

  void stopContainer() async {
    if (isLoading) return;
    setWhaleState(WhaleState.stopping);
    setState(() {
      message = 'Stop 진행 중...';
      whalePosition = 0;
    });

    if (confettiVisible) {
      Timer.periodic(const Duration(milliseconds: 50), (timer) {
        setState(() {
          confettiScale -= 0.05;
          confettiOpacity -= 0.07;
          confettiOffsetY += 0.05;
        });
        if (confettiScale <= 0 || confettiOpacity <= 0) {
          timer.cancel();
          setState(() {
            confettiVisible = false;
            confettiScale = 1.0;
            confettiOpacity = 1.0;
            confettiOffsetY = 0.0;
            boxOpen = false;
            hasBox = true;
            boxSize = 30;
            message = 'Stop 완료!';
            whaleState = WhaleState.idle;
          });
        }
      });
    } else {
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        message = 'Stop 완료!';
        whaleState = WhaleState.idle;
        boxOpen = false;
        confettiVisible = false;
        hasBox = true;
        boxSize = 30;
      });
    }
  }

  void removeDockerContainer() async {
    if (isLoading) return;
    setWhaleState(WhaleState.deleting);
    setState(() {
      message = '컨테이너 삭제 중...';
      whalePosition = 0;
      showBeach = true;
      boxOpen = false;
      confettiVisible = false;
    });

    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      whalePosition = -1;
    });

    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      hasBox = false;
      whalePosition = 0;
      message = '삭제 완료!';
    });

    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      showBeach = false;
    });

    setWhaleState(WhaleState.idle);
  }

  Future<bool> fakeBuildResult() async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<bool> fakeRunResult() async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  void setWhaleState(WhaleState newState) {
    setState(() {
      whaleState = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Docker 빌드 및 실행',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    whaleWidget(),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: cpuController,
                            decoration: const InputDecoration(
                              labelText: 'CPU',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: memoryController,
                            decoration: const InputDecoration(
                              labelText: 'Memory',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: portController,
                            decoration: const InputDecoration(
                              labelText: 'Port',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildButton(
                      'Build',
                      Colors.blue.shade300,
                      buildDockerContainer,
                    ),
                    _buildButton(
                      'Run',
                      Colors.blue.shade400,
                      runDockerContainer,
                    ),
                    _buildButton('Stop', Colors.blue.shade500, stopContainer),
                    _buildButton(
                      'Delete',
                      Colors.blue.shade600,
                      removeDockerContainer,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      message,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      'WhaleDev 2025',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildButton(String label, Color color, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(label),
        ),
      ),
    );
  }
}
