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
  bool isStopInProgress = false; // Stop 작업 진행 중인지 확인하는 플래그

  // Docker 빌드에 필요한 값들
  late String userId; // userId를 동적으로 설정
  late String username;
  late String localPath;
  String basePath =
      '/home/hanjeongjin/Workspace_ubuntu/backend/madcampweek2-backend/F:/workspace/server_manage/home';
  String imageName = 'custom-image-name'; // 임의로 설정한 imageName

  // CPU, 메모리, 포트 값 설정을 위한 컨트롤러
  final TextEditingController cpuController = TextEditingController(
    text: '0.5',
  );
  final TextEditingController memoryController = TextEditingController(
    text: '200MB',
  );
  final TextEditingController portController = TextEditingController(
    text: '8080:80',
  );

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

  // CPU 값 유효성 검사 (0.1 이상 16 이하)
  bool isValidCpu(String cpu) {
    try {
      final value = double.parse(cpu);
      return value >= 0.1 && value <= 16.0;
    } catch (_) {
      return false;
    }
  }

  // Memory 값 유효성 검사 (50MB 이상 16GB 이하)
  bool isValidMemory(String memory) {
    try {
      final value = int.parse(memory.replaceAll(RegExp(r'[^0-9]'), ''));
      return value >= 50 && value <= 16384; // 50MB ~ 16GB (16384MB)
    } catch (_) {
      return false;
    }
  }

  // Port 값 유효성 검사 (1024 ~ 65535)
  bool isValidPort(String port) {
    try {
      final value = int.parse(port.split(':')[0]);
      return value >= 1024 && value <= 65535;
    } catch (_) {
      return false;
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

    String cpu = cpuController.text.trim();
    String memory = memoryController.text.trim();
    String port = portController.text.trim();

    if (!isValidCpu(cpu)) {
      setState(() {
        message = 'CPU 값은 0.1 이상 16.0 이하의 값이어야 합니다.';
      });
      return;
    }

    if (!isValidMemory(memory)) {
      setState(() {
        message = 'Memory 값은 50MB 이상 16GB 이하이어야 합니다.';
      });
      return;
    }

    if (!isValidPort(port)) {
      setState(() {
        message = 'Port 값은 1024 이상 65535 이하이어야 합니다.';
      });
      return;
    }

    setState(() {
      message = 'Docker 빌드 중...';
    });

    try {
      final response = await ApiService.dockerBuild(
        widget.token,
        userId, // 동적으로 설정된 userId 사용
        localPath, // 임의로 설정된 localPath 사용
        imageName, // 임의로 설정된 imageName 사용
      ); // Docker 빌드 요청
      if (!mounted) return;
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

  // Docker 실행 함수
  void runDockerContainer() async {
    if (isLoading) {
      setState(() {
        message = 'Loading user data...'; // 데이터 로딩 중 메시지
      });
      return;
    }

    // userId가 로드되었을 때만 Docker 실행을 진행하도록 함
    if (userId.isEmpty) {
      setState(() {
        message = 'User ID is not available.';
      });
      return;
    }

    try {
      // 1. 세션을 가져오기 위한 API 호출
      final sessionResponse = await ApiService.getSession(widget.token, userId);
      if (sessionResponse.statusCode == 200) {
        final sessionData = jsonDecode(sessionResponse.body);

        // sessionData가 배열이므로 첫 번째 세션 객체에서 sessionId 추출
        final sessionId = sessionData[0]['_id']; // 배열에서 첫 번째 객체의 sessionId 추출

        // 2. Docker 컨테이너 실행 요청
        final response = await ApiService.dockerRun(
          widget.token,
          sessionId,
          cpuController.text.trim(), // 사용자가 입력한 CPU
          memoryController.text.trim(), // 사용자가 입력한 메모리
          portController.text.trim(), // 사용자가 입력한 포트
        );

        // 3. 실행 결과 처리
        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          // Docker 실행이 성공적으로 되면, response에서 반환된 포트 정보 추출
          String mappedPort = responseData['port']; // API 응답에서 포트 번호 추출
          String backendServerUrl = 'http://143.248.183.61'; // 여기를 실제 서버 주소로 설정
          String fullUrl = '$backendServerUrl:$mappedPort'; // 포트 번호와 URL을 결합

          setState(() {
            message = 'Docker container 실행 성공! 백엔드 URL: $fullUrl';
          });
        } else {
          setState(() {
            message = 'Docker container 실행 실패: ${response.body}';
          });
        }
      } else {
        setState(() {
          message = '세션 조회 실패: ${sessionResponse.body}';
        });
      }
    } catch (e) {
      setState(() {
        message = '컨테이너 실행 중 오류 발생: $e'; // 실행 관련 에러 메시지
      });
    }
  }

  // Stop container 함수
  // void stopContainer() async {
  //   try {
  //     final sessionResponse = await ApiService.getSession(widget.token, userId);
  //     if (sessionResponse.statusCode == 200) {
  //       final sessionData = jsonDecode(sessionResponse.body);
  //       final sessionId = sessionData[0]['_id'];
  //       final containerId = sessionData[0]['container_id'];

  //       final stopResponse = await ApiService.stopContainer(
  //         widget.token,
  //         containerId,
  //         sessionId,
  //       );

  //       if (stopResponse.statusCode == 200) {
  //         setState(() {
  //           message = 'Container stopped successfully!';
  //         });
  //       } else {
  //         setState(() {
  //           message = 'Failed to stop container: ${stopResponse.body}';
  //         });
  //       }
  //     }
  //   } catch (e) {
  //     setState(() {
  //       message = 'Error stopping container: $e';
  //     });
  //   }
  // }

  // Docker Stop 함수
  void stopContainer() async {
    if (isLoading) {
      setState(() {
        message = 'Loading user data...'; // 데이터 로딩 중 메시지
      });
      return;
    }

    // userId가 로드되었을 때만 Docker 실행을 진행하도록 함
    if (userId.isEmpty) {
      setState(() {
        message = 'User ID is not available.';
      });
      return;
    }

    setState(() {
      message = 'Stop 진행 중...';
      isStopInProgress = true; // Stop 작업이 진행 중임을 나타냄
    });

    try {
      // 1. 세션을 가져오기 위한 API 호출
      final sessionResponse = await ApiService.getSession(widget.token, userId);
      if (sessionResponse.statusCode == 200) {
        final sessionData = jsonDecode(sessionResponse.body);
        final sessionId = sessionData[0]['_id'];
        final containerId = sessionData[0]['container_id'];

        final stopResponse = await ApiService.stopContainer(
          widget.token,
          containerId,
          sessionId,
        );

        if (stopResponse.statusCode == 200) {
          setState(() {
            message = 'Container stopped successfully!';
            isStopInProgress = false; // Stop 작업 완료
          });
        } else {
          setState(() {
            message = 'Failed to stop container: ${stopResponse.body}';
            isStopInProgress = false; // Stop 작업 완료
          });
        }
      }
    } catch (e) {
      setState(() {
        message = 'Error stopping container: $e';
        isStopInProgress = false; // Stop 작업 완료
      });
    }
  }

  // Remove container 함수
  void removeDockerContainer() async {
    if (isLoading) {
      setState(() {
        message = 'Loading user data...'; // 데이터 로딩 중 메시지
      });
      return;
    }

    // userId가 로드되었을 때만 Docker 실행을 진행하도록 함
    if (userId.isEmpty) {
      setState(() {
        message = 'User ID is not available.';
      });
      return;
    }

    try {
      // 1. 세션을 가져오기 위한 API 호출
      final sessionResponse = await ApiService.getSession(widget.token, userId);
      if (sessionResponse.statusCode == 200) {
        final sessionData = jsonDecode(sessionResponse.body);

        // sessionData가 배열이므로 첫 번째 세션 객체에서 sessionId 추출
        final sessionId = sessionData[0]['_id']; // 배열에서 첫 번째 객체의 sessionId 추출
        final containerId = sessionData[0]['container_id']; // 컨테이너 ID 추출

        // 2. Docker 컨테이너 삭제 요청
        final response = await ApiService.removeContainer(
          containerId,
          widget.token,
        );

        // 3. 실행 결과 처리
        if (response.statusCode == 200) {
          setState(() {
            message = 'Docker container removed successfully!';
          });
        } else {
          setState(() {
            message = 'Docker container removal failed: ${response.body}';
          });
        }
      } else {
        setState(() {
          message = 'Session not found: ${sessionResponse.body}';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Error removing container: $e';
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
      appBar: AppBar(title: const Text('Docker 빌드 및 실행')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      // CPU, 메모리, 포트 값을 입력받는 텍스트 필드 추가
                      TextField(
                        controller: cpuController,
                        decoration: const InputDecoration(
                          labelText: 'CPU (예: 0.5)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: memoryController,
                        decoration: const InputDecoration(
                          labelText: 'Memory (예: 200MB)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: portController,
                        decoration: const InputDecoration(
                          labelText: 'Port (예: 8080:80)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: buildDockerContainer,
                        child: const Text('Build Docker Image'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: runDockerContainer,
                        child: const Text('Run Docker Container'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: stopContainer,
                        child: const Text('Stop Container'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: removeDockerContainer,
                        child: const Text('Remove Docker Container'),
                      ),
                    ],
                  ),
            const SizedBox(height: 20),
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
