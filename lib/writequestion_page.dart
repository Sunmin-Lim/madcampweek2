import 'package:flutter/material.dart';
import 'api_service.dart';

class WriteQuestionPage extends StatefulWidget {
  const WriteQuestionPage({super.key});

  @override
  State<WriteQuestionPage> createState() => _WriteQuestionPageState();
}

class _WriteQuestionPageState extends State<WriteQuestionPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final tagsController = TextEditingController();

  bool isSubmitting = false;

  void submit() async {
    final title = titleController.text.trim();
    final content = contentController.text.trim();
    final tags = tagsController.text.split(',').map((e) => e.trim()).toList();

    if (title.isEmpty) return;

    setState(() => isSubmitting = true);
    try {
      await ApiService.createPost(title, content, tags);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('질문 작성하기')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: '제목'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: '내용'),
              maxLines: 5,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: tagsController,
              decoration: const InputDecoration(labelText: '태그 (쉼표로 구분)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: isSubmitting ? null : submit,
              child: const Text('등록'),
            ),
          ],
        ),
      ),
    );
  }
}
