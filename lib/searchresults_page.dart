import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'api_service.dart';

class SearchResultsPage extends StatefulWidget {
  final String query;

  const SearchResultsPage({super.key, required this.query});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  List<dynamic> results = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchResults();
  }

  Future<void> fetchResults() async {
    setState(() => isLoading = true);
    try {
      // 👇 Use the NEW GET endpoint
      final data = await ApiService.crawlGoogleAndGetResults(widget.query);
      setState(() => results = data);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _launchLink(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invalid URL')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('검색 결과: ${widget.query}')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : results.isEmpty
          ? const Center(child: Text('검색 결과가 없습니다.'))
          : ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final item = results[index];
                final link =
                    (item['answers'] != null && item['answers'].isNotEmpty)
                    ? item['answers'][0]['text']
                    : null;
                return Card(
                  child: ListTile(
                    title: Text(item['title'] ?? ''),
                    subtitle: Text(item['content'] ?? ''),
                    trailing: link != null
                        ? IconButton(
                            icon: const Icon(Icons.open_in_new),
                            onPressed: () => _launchLink(link),
                          )
                        : null,
                  ),
                );
              },
            ),
    );
  }
}
