// warning_message_float.dart

import 'package:flutter/material.dart';

// class WarningMessageWidget extends StatelessWidget {
//   final String message;

//   const WarningMessageWidget({Key? key, required this.message})
//     : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color.fromARGB(255, 219, 67, 67).withOpacity(0.7), // 배경에 반투명 색을 주어 화면을 가리게 함
//       padding: const EdgeInsets.all(16.0),
//       width: double.infinity, // 화면 전체 너비
//       child: Center(
//         child: Text(
//           message,
//           style: const TextStyle(color: Colors.white, fontSize: 16),
//         ),
//       ),
//     );
//   }
// }

class WarningMessageWidget extends StatelessWidget {
  final String repoUrl; // 'repoUrl' 추가
  final int remainingTime; // 'remainingTime' 추가

  const WarningMessageWidget({
    Key? key,
    required this.repoUrl,
    required this.remainingTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(
        255,
        219,
        67,
        67,
      ).withOpacity(0.7), // 배경에 반투명 색을 주어 화면을 가리게 함
      padding: const EdgeInsets.all(16.0),
      width: double.infinity, // 화면 전체 너비
      child: Center(
        child: Column(
          children: [
            Text(
              'GitHub Repo: $repoUrl', // GitHub Repo 링크 표시
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Remaining Time: ${remainingTime ~/ 1000}s', // 남은 시간 표시
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
