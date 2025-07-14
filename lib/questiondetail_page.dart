import 'package:flutter/material.dart';
import 'api_service.dart';

class QuestionDetailPage extends StatefulWidget {
  final String postId;

  const QuestionDetailPage({super.key, required this.postId});

  @override
  State<QuestionDetailPage> createState() => _QuestionDetailPageState();
}

class _QuestionDetailPageState extends State<QuestionDetailPage> {
  Map<String, dynamic>? post;

  @override
  void initState() {
    super.initState();
    loadPost();
  }

  Future<void> loadPost() async {
    final allPosts = await ApiService.getTopPosts();
    setState(() {
      post = allPosts.firstWhere((p) => p['_id'] == widget.postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('질문 상세')),
      body: post == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post!['title'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(post!['content'] ?? ''),
                  const SizedBox(height: 8),
                  Text('태그: ${post!['tags'].join(', ')}'),
                ],
              ),
            ),
    );
  }
}
