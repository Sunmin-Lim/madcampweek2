import 'package:flutter/material.dart';
import 'search_page.dart';

class GlobalScaffold extends StatelessWidget {
  final Widget child;

  const GlobalScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.help_outline),
        tooltip: '질문 검색 / 작성',
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
