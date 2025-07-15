// import 'package:flutter/material.dart';

// class WarningPage extends StatelessWidget {
//   const WarningPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Warning'),
//         backgroundColor: Colors.redAccent,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Icon(Icons.warning, size: 100, color: Colors.redAccent),
//             SizedBox(height: 16),
//             Text('Warning Page Placeholder', style: TextStyle(fontSize: 20)),
//             SizedBox(height: 8),
//             Text(
//               'This is a placeholder screen for warnings.',
//               style: TextStyle(fontSize: 14, color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'warning_message.dart'; // 앞서 만든 메시지 박스 컴포넌트 import

class WarningPage extends StatefulWidget {
  const WarningPage({super.key});

  @override
  State<WarningPage> createState() => _WarningPageState();
}

class _WarningPageState extends State<WarningPage> {
  final List<String> _messages = [];

  // 새로운 메시지 추가 함수
  void addWarningMessage(String message) {
    setState(() {
      _messages.add(message);
    });
  }

  // 메시지 삭제 함수 (5초 후 WarningMessage에서 호출)
  void removeMessage(String message) {
    setState(() {
      _messages.remove(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Warning'),
        backgroundColor: Colors.redAccent,
      ),
      body: _messages.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.warning, size: 100, color: Colors.redAccent),
                  SizedBox(height: 16),
                  Text('No warnings yet.', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 8),
                  Text(
                    'Warnings will appear here as they come.',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return WarningMessage(
                  message: msg,
                  onDismissed: () => removeMessage(msg),
                );
              },
            ),
    );
  }
}
