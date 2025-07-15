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
  final TextEditingController pinNameController = TextEditingController();
  final TextEditingController pinUrlController = TextEditingController();

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
    pinNameController.dispose();
    pinUrlController.dispose();
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

  void addPinnedLink(String name, String url) {
    setState(() {
      pinnedLinks.add({'name': name, 'url': url});
    });
    savePinnedLinks();
  }

  void removePinnedLink(int index) {
    setState(() {
      pinnedLinks.removeAt(index);
    });
    savePinnedLinks();
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
        ).showSnackBar(SnackBar(content: Text('검색 오류: $e')));
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> onAskQuestion() async {
    final query = searchController.text.trim();
    if (query.isEmpty) return;

    setState(() => isLoading = true);
    try {
      await ApiService.crawlGoogleAndGetResults(query);
      await onSearch(); // refresh results after asking
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('✅ 질문이 등록되었습니다.')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('질문 등록 오류: $e')));
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  void showAddPinnedDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('📌 새 링크 추가'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: pinNameController,
              decoration: const InputDecoration(hintText: '이름'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: pinUrlController,
              decoration: const InputDecoration(hintText: 'URL'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              final name = pinNameController.text.trim();
              final url = pinUrlController.text.trim();
              if (name.isNotEmpty && url.isNotEmpty) {
                addPinnedLink(name, url);
              }
              pinNameController.clear();
              pinUrlController.clear();
              Navigator.pop(context);
            },
            child: const Text('저장'),
          ),
        ],
      ),
    );
  }

  Widget buildPinnedLinksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '📌 내가 고정한 링크',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (pinnedLinks.isEmpty)
          const Text('아직 고정한 링크가 없습니다.')
        else
          Column(
            children: pinnedLinks
                .asMap()
                .entries
                .map(
                  (entry) => Card(
                    child: ListTile(
                      title: Text(entry.value['name']!),
                      subtitle: Text(entry.value['url']!),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => removePinnedLink(entry.key),
                      ),
                      onTap: () => launchUrl(Uri.parse(entry.value['url']!)),
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
          '🔎 검색 결과',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (results.isEmpty)
          const Text('검색 결과가 없습니다.')
        else
          Column(
            children: results
                .map(
                  (item) => Card(
                    child: ListTile(
                      title: Text(item['title'] ?? ''),
                      subtitle: Text(item['content'] ?? ''),
                      onTap: () {
                        if (item['answers'] != null &&
                            item['answers'].isNotEmpty) {
                          final link = item['answers'][0]['text'];
                          launchUrl(Uri.parse(link));
                        }
                      },
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('질문 검색 / 작성'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_link),
            tooltip: '📌 링크 추가하기',
            onPressed: showAddPinnedDialog,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search / Ask bar
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: const InputDecoration(
                            hintText: '질문을 검색하거나 작성하세요...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        tooltip: '검색하기',
                        onPressed: onSearch,
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        tooltip: '질문 등록',
                        onPressed: onAskQuestion,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  buildPinnedLinksSection(),
                  buildResultsSection(),
                ],
              ),
            ),
    );
  }
}
