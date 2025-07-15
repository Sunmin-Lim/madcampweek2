import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'api_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  List<dynamic> results = [];
  List<Map<String, String>> pinnedLinks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadPinnedLinks();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> loadPinnedLinks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('pinnedLinks');
    if (data != null) {
      setState(() {
        pinnedLinks = List<Map<String, String>>.from(
          jsonDecode(data).map((e) => Map<String, String>.from(e)),
        );
      });
    }
  }

  Future<void> savePinnedLinks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pinnedLinks', jsonEncode(pinnedLinks));
  }

  void togglePin(String name, String url) {
    final existingIndex = pinnedLinks.indexWhere((link) => link['url'] == url);
    setState(() {
      if (existingIndex != -1) {
        pinnedLinks.removeAt(existingIndex);
      } else {
        pinnedLinks.add({'name': name, 'url': url});
      }
    });
    savePinnedLinks();
  }

  bool isPinned(String url) {
    return pinnedLinks.any((link) => link['url'] == url);
  }

  Future<void> onSearch() async {
    final query = searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      isLoading = true;
      results = [];
    });

    try {
      results = await ApiService.searchPostsByTag(query);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Search error: $e')));
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget buildPinnedLinksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text(
          '📌 My Pinned Links',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (pinnedLinks.isEmpty)
          const Text('No pinned links yet.')
        else
          Column(
            children: pinnedLinks
                .map(
                  (entry) => Card(
                    child: ListTile(
                      title: Text(entry['name'] ?? ''),
                      subtitle: Text(entry['url'] ?? ''),
                      trailing: IconButton(
                        icon: const Icon(Icons.star, color: Colors.amber),
                        onPressed: () =>
                            togglePin(entry['name']!, entry['url']!),
                      ),
                      onTap: () => launchUrl(Uri.parse(entry['url']!)),
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }

  Widget buildResultsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const Text(
          '🔎 Search Results',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (results.isEmpty)
          const Text('No search results.')
        else
          Column(
            children: results.map((item) {
              final title = item['title'] ?? '';
              final content = item['content'] ?? '';
              final link =
                  (item['answers'] != null && item['answers'].isNotEmpty)
                  ? item['answers'][0]['text']
                  : null;

              return Card(
                child: ListTile(
                  title: Text(title),
                  subtitle: Text(content),
                  trailing: link != null
                      ? IconButton(
                          icon: Icon(
                            isPinned(link) ? Icons.star : Icons.star_border,
                            color: isPinned(link) ? Colors.amber : null,
                          ),
                          onPressed: () => togglePin(title, link),
                        )
                      : null,
                  onTap: () {
                    if (link != null) {
                      launchUrl(Uri.parse(link));
                    }
                  },
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('Search / Ask a Question'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: const InputDecoration(
                            hintText: 'Search for questions...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        tooltip: 'Search',
                        onPressed: onSearch,
                      ),
                    ],
                  ),
                  buildPinnedLinksSection(),
                  buildResultsSection(),
                ],
              ),
            ),
    );
  }
}
