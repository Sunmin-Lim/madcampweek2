// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:app_links/app_links.dart';
// import 'package:video_player/video_player.dart';

// import 'api_service.dart';
// import 'register_page.dart';
// import 'home_page.dart';
// import 'socket_service.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   // static const String serverIp = 'http://143.248.184.42:3000';
//   // static const String serverIp = 'http://143.248.183.61:3000';
//   static const String serverIp = 'http://143.248.183.37:3000';

//   static const String authBase = '$serverIp/api/auth';

//   String message = '';
//   StreamSubscription<Uri>? _linkSubscription;

//   late VideoPlayerController _videoController;
//   bool _videoInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _handleIncomingLinks(socketService, userId);
//     _initializeVideo();
//   }

//   void _initializeVideo() async {
//     _videoController = VideoPlayerController.asset('assets/videos/whale.mp4');
//     await _videoController.initialize();
//     _videoController.setLooping(true);
//     _videoController.play();

//     setState(() {
//       _videoInitialized = true;
//     });
//   }

//   void _handleIncomingLinks(socketService, userId) {
//     final appLinks = AppLinks();
//     _linkSubscription?.cancel();

//     _linkSubscription = appLinks.uriLinkStream.listen(
//       (uri) {
//         print('📥 수신된 딥링크 URI: $uri');

//         if (uri.toString().startsWith('myapp://callback')) {
//           final code = uri.queryParameters['code'];
//           print('✅ 앱에서 받은 GitHub code: $code');

//           if (code != null && code.isNotEmpty) {
//             final apiService = ApiService();
//             apiService.sendCodeToBackend(code, context, scocketService, userId);
//           }
//         }
//       },
//       onError: (err) {
//         print('❌ 딥링크 수신 중 오류: $err');
//       },
//     );
//   }

//   // void login() async {
//   //   final response = await ApiService.login(
//   //     emailController.text,
//   //     passwordController.text,
//   //   );

//   //   if (response.statusCode == 200) {
//   //     final data = jsonDecode(response.body);
//   //     final token = data['token'];

//   //     setState(() {
//   //       message = '로그인 성공! 토큰: $token';
//   //     });

//   //     Navigator.push(
//   //       context,
//   //       MaterialPageRoute(builder: (context) => HomePage(token: token)),
//   //     );
//   //   } else {
//   //     setState(() {
//   //       message = jsonDecode(response.body)['message'];
//   //     });
//   //   }
//   // }

//   void login() async {
//     final response = await ApiService.login(
//       emailController.text,
//       passwordController.text,
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       final token = data['token'];

//       // token을 통해 사용자 ID를 가져옴
//       final userResponse = await ApiService.getUserId(token);
//       if (userResponse.statusCode == 200) {
//         final userData = jsonDecode(userResponse.body);
//         final userId = userData['id']; // 여기서 userId를 가져옵니다

//         setState(() {
//           message = '로그인 성공! 토큰: $token';
//         });

//         final socketService = SocketService();
//         socketService.connect(userId); // userId로 소켓 연결

//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => HomePage(
//               token: token,
//               socketService: socketService,
//               userId: userId,
//             ),
//           ),
//         );
//       } else {
//         setState(() {
//           message = '사용자 ID 가져오기 실패';
//         });
//       }
//     } else {
//       setState(() {
//         message = jsonDecode(response.body)['message'];
//       });
//     }
//   }

//   String? token;

//   void logout() async {
//     if (token == null) return;

//     final response = await ApiService.logout(token!);

//     if (response.statusCode == 200) {
//       setState(() {
//         token = null;
//         message = '로그아웃 되었습니다.';
//       });
//     } else {
//       setState(() {
//         message = jsonDecode(response.body)['message'] ?? '로그아웃 실패';
//       });
//     }
//   }

//   void loginWithGitHub() async {
//     const clientId = 'Ov23liBt79Q7o2NROraV';
//     const redirectUri = 'myapp://callback';

//     final authUrl = Uri.parse(
//       'https://github.com/login/oauth/authorize'
//       '?client_id=$clientId'
//       '&redirect_uri=$redirectUri'
//       '&scope=user:email',
//     );

//     try {
//       if (await canLaunchUrl(authUrl)) {
//         await launchUrl(authUrl, mode: LaunchMode.externalApplication);
//       } else {
//         print('❌ GitHub 로그인 페이지 열기 실패');
//       }
//     } catch (e) {
//       print('❌ GitHub 로그인 실패: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _linkSubscription?.cancel();
//     emailController.dispose();
//     passwordController.dispose();
//     _videoController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 28.0,
//                 vertical: 24.0,
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 24),
//                   const Text(
//                     'BackOverFlow',
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const SizedBox(height: 24),

//                   // Whale Video as Logo
//                   Container(
//                     width: 200,
//                     height: 200,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: _videoInitialized
//                         ? ClipRRect(
//                             borderRadius: BorderRadius.circular(16),
//                             child: VideoPlayer(_videoController),
//                           )
//                         : const Center(child: CircularProgressIndicator()),
//                   ),

//                   const SizedBox(height: 32),

//                   // Email Field
//                   TextField(
//                     controller: emailController,
//                     decoration: const InputDecoration(
//                       labelText: 'enter your email',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),

//                   const SizedBox(height: 16),

//                   // Password Field
//                   TextField(
//                     controller: passwordController,
//                     obscureText: true,
//                     decoration: const InputDecoration(
//                       labelText: 'enter your password',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),

//                   const SizedBox(height: 32),

//                   // Login Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: login,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.lightBlue,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text(
//                         'login',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 12),

//                   // Sign Up Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const RegisterPage(),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text(
//                         'sign up',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 12),

//                   // GitHub Login Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: loginWithGitHub,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.black,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Image.asset(
//                             'assets/images/githublogo.png',
//                             height: 24,
//                             width: 24,
//                           ),
//                           const SizedBox(width: 12),
//                           const Text(
//                             'gitHub login',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 12),

//                   if (message.isNotEmpty)
//                     Text(message, style: const TextStyle(color: Colors.red)),

//                   const SizedBox(height: 24),

//                   Text(
//                     'BackOverFlow 2025',
//                     style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
//                   ),
//                 ],
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
import 'package:url_launcher/url_launcher.dart';
import 'package:app_links/app_links.dart';
import 'package:video_player/video_player.dart';

import 'api_service.dart';
import 'register_page.dart';
import 'home_page.dart';
import 'package:provider/provider.dart';
import 'socket_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  static const String serverIp = 'http://143.248.183.37:3000';
  static const String authBase = '$serverIp/api/auth';

  String message = '';
  StreamSubscription<Uri>? _linkSubscription;

  late VideoPlayerController _videoController;
  bool _videoInitialized = false;
  late String userId;
  late String username;

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
    _initializeVideo();
  }

  // Initialize Video Player
  void _initializeVideo() async {
    _videoController = VideoPlayerController.asset('assets/videos/whale.mp4');
    await _videoController.initialize();
    _videoController.setLooping(true);
    _videoController.play();

    setState(() {
      _videoInitialized = true;
    });
  }

  // Handle deep link callbacks (for GitHub OAuth)
  void _handleIncomingLinks() {
    final appLinks = AppLinks();
    _linkSubscription?.cancel();

    _linkSubscription = appLinks.uriLinkStream.listen(
      (uri) {
        print('📥 Received deep link URI: $uri');

        if (uri.toString().startsWith('myapp://callback')) {
          final code = uri.queryParameters['code'];
          print('✅ GitHub code received from app: $code');

          if (code != null && code.isNotEmpty) {
            final apiService = ApiService();
            apiService.sendCodeToBackend(code, context, username);
          }
        }
      },
      onError: (err) {
        print('❌ Error receiving deep link: $err');
      },
    );
  }

  // Perform login with email and password
  void login() async {
    final response = await ApiService.login(
      emailController.text,
      passwordController.text,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      // token을 통해 사용자 ID를 가져옴
      final userResponse = await ApiService.getUserId(token);
      if (userResponse.statusCode == 200) {
        final userData = jsonDecode(userResponse.body);
        final userId = userData['userId']; // 여기서 userId를 가져옵니다
        final username = userData['username']; // 사용자 이름도 가져옵니다

        print("userId: $userId, username: $username");

        setState(() {
          message = '로그인 성공! 토큰: $token';
        });

        // 로그인 성공 후 SocketProvider에 값 초기화
        final socketProvider = Provider.of<SocketProvider>(
          context,
          listen: false,
        );
        socketProvider.initialize(userId);
        print("✅ SocketProvider initialized with userId: $userId");
        // socketService.connect(userId); // userId로 소켓 연결

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(token: token, username: username),
          ),
        );
      } else {
        setState(() {
          message = '사용자 ID 가져오기 실패';
        });
      }
    } else {
      setState(() {
        message = jsonDecode(response.body)['message'];
      });
    }
  }

  // Perform GitHub login redirect
  void loginWithGitHub() async {
    const clientId = 'Ov23liBt79Q7o2NROraV';
    const redirectUri = 'myapp://callback';

    final authUrl = Uri.parse(
      'https://github.com/login/oauth/authorize'
      '?client_id=$clientId'
      '&redirect_uri=$redirectUri'
      '&scope=user:email',
    );

    try {
      if (await canLaunchUrl(authUrl)) {
        await launchUrl(authUrl, mode: LaunchMode.externalApplication);
      } else {
        print('❌ Failed to open GitHub login page');
      }
    } catch (e) {
      print('❌ GitHub login failed: $e');
    }
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    emailController.dispose();
    passwordController.dispose();
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    'BackOverFlow',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Whale Video as Logo
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

                  // Email Field
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your email',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Password Field
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Enter your password',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // GitHub Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: loginWithGitHub,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/githublogo.png',
                            height: 24,
                            width: 24,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'GitHub Login',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  if (message.isNotEmpty)
                    Text(message, style: const TextStyle(color: Colors.red)),

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
