import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'api_service.dart';

class QuestionDetailPage extends StatefulWidget {
  final String postId;

  const QuestionDetailPage({super.key, required this.postId});

  @override
  State<QuestionDetailPage> createState() => _QuestionDetailPageState();
}

class _QuestionDetailPageState extends State<QuestionDetailPage> {
  Map<String, dynamic>? post;
  final TextEditingController answerController = TextEditingController();
  bool isLoading = true;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    loadPost();
  }

  Future<void> loadPost() async {
    setState(() => isLoading = true);
    try {
      final fetched = await ApiService.getPostById(widget.postId);
      setState(() => post = fetched);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> submitAnswer() async {
    final text = answerController.text.trim();
    if (text.isEmpty) return;
    setState(() => isSubmitting = true);
    try {
      await ApiService.addAnswer(widget.postId, text);
      answerController.clear();
      await loadPost();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('등록 실패: $e')));
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  Widget buildAnswerItem(String text) {
    final isLink = text.startsWith('http');
    if (isLink) {
      return GestureDetector(
        onTap: () => launchUrl(Uri.parse(text)),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ),
      );
    } else {
      return Text(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('질문 상세')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : post == null
          ? const Center(child: Text('질문을 불러올 수 없습니다.'))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post!['title'] ?? '',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(post!['content'] ?? ''),
                    const SizedBox(height: 8),
                    Text('태그: ${post!['tags']?.join(', ') ?? ''}'),
                    const Divider(height: 32),
                    const Text(
                      '답변 목록',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (post!['answers'] != null && post!['answers'].isNotEmpty)
                      ...post!['answers'].map<Widget>(
                        (answer) => Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: buildAnswerItem(answer['text']),
                          ),
                        ),
                      )
                    else
                      const Text('아직 답변이 없습니다.'),
                    const SizedBox(height: 24),
                    const Divider(),
                    const Text(
                      '내 답변 작성',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: answerController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: '여기에 답변을 작성하세요...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: isSubmitting ? null : submitAnswer,
                      child: isSubmitting
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('등록'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
