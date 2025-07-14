import 'package:flutter/material.dart';

class WarningPage extends StatelessWidget {
  const WarningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Warning'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.warning, size: 100, color: Colors.redAccent),
            SizedBox(height: 16),
            Text('Warning Page Placeholder', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text(
              'This is a placeholder screen for warnings.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
