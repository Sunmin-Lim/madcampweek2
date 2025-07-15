import 'package:flutter/material.dart';
import 'api_service.dart';
import 'writequestion_page.dart';
import 'questiondetail_page.dart';
import 'searchresults_page.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  List<dynamic> topPosts = [];
  List<dynamic> usefulLinks = [];
  final TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() => isLoading = true);
    try {
      final posts = await ApiService.getTopPosts();
      final links = await ApiService.getUsefulLinks();
      setState(() {
        topPosts = posts;
        usefulLinks = links;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  void onSearch() {
    final query = searchController.text.trim();
    if (query.isEmpty) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SearchResultsPage(query: query)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Community')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: const InputDecoration(
                            hintText: '질문 검색...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: onSearch,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Useful Links',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...usefulLinks.map(
                    (link) => ListTile(
                      title: Text(link['name']),
                      subtitle: Text(link['url']),
                      onTap: () => launchUrl(Uri.parse(link['url'])),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Top 3 인기 질문',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  ...topPosts.map(
                    (post) => Card(
                      child: ListTile(
                        title: Text(post['title']),
                        onTap: () async {
                          await ApiService.incrementView(post['_id']);
                          if (context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    QuestionDetailPage(postId: post['_id']),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const WriteQuestionPage(),
                        ),
                      );
                    },
                    child: const Text('+ 질문 작성하기'),
                  ),
                ],
              ),
            ),
    );
  }
}
