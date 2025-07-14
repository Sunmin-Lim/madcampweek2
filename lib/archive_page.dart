import 'package:flutter/material.dart';

class ArchivePage extends StatelessWidget {
  final String token;
  final String repoUrl;

  const ArchivePage({super.key, required this.token, required this.repoUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Archive'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.archive, size: 100, color: Colors.blueGrey),
            const SizedBox(height: 16),
            const Text(
              'Archive Page Placeholder',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              'Token: $token',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              'Repo URL: $repoUrl',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
