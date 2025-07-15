import 'package:flutter/material.dart';
import 'search_page.dart';
import 'warning_page.dart';
import 'community_page.dart';

class ArchivePage extends StatelessWidget {
  final String token;
  final String repoUrl;
  final String? userId;

  const ArchivePage({
    super.key,
    required this.token,
    required this.repoUrl,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Archive', style: TextStyle(color: Colors.black)),
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
                MaterialPageRoute(builder: (_) => const WarningPage()),
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
                  builder: (_) => CommunityPage(token: token, userId: userId!),
                ),
              );
            },
          ),
        ],
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
