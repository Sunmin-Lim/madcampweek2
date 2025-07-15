// import 'package:flutter/material.dart';
// import 'login_page.dart';
// import 'package:provider/provider.dart';
// import 'socket_provicer.dart';
// import 'socket_service.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: Colors.white,
//         useMaterial3: false,
//       ),
//       home: const LoginPage(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:provider/provider.dart';
import 'socket_provider.dart'; // SocketProvider 임포트

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SocketProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: false,
      ),
      home: const LoginPage(),
    );
  }
}
