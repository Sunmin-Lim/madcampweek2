// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'warning_message.dart';
// import 'socket_provider.dart';

// class WarningPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // SocketProvider로부터 데이터 받기
//     final socketProvider = Provider.of<SocketProvider>(context);

//     return Scaffold(
//       appBar: AppBar(title: const Text("Warning Messages")),
//       body: socketProvider.warnings.isEmpty
//           ? const Center(child: Text("No active warnings"))
//           : ListView.builder(
//               itemCount: socketProvider.warnings.length,
//               itemBuilder: (context, index) {
//                 final warning = socketProvider.warnings[index];
//                 return WarningMessage(
//                   repoUrl: warning['repo_url'],
//                   remainingTime: warning['remaining_time_ms'],
//                 );
//               },
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'socket_provider.dart';

class WarningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SocketProvider를 Consumer로 감싸서 데이터가 변경될 때마다 자동으로 갱신되도록 설정
    return Consumer<SocketProvider>(
      builder: (context, socketProvider, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Warnings")),
          body: socketProvider.warnings.isEmpty
              ? Center(child: Text("No active sessions"))
              : ListView.builder(
                  itemCount: socketProvider.warnings.length,
                  itemBuilder: (context, index) {
                    var warning = socketProvider.warnings[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      child: ListTile(
                        title: Text("GitHub Repo: ${warning['repo_url']}"),
                        subtitle: Text(
                          "Remaining Time: ${warning['remaining_time_ms']} ms",
                        ),
                        tileColor: Colors.lightBlueAccent,
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
