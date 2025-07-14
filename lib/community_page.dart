import 'package:flutter/material.dart';
import 'api_service.dart';
import 'writequestion_page.dart';
import 'questiondetail_page.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  List<dynamic> usefulLinks = [];
  List<dynamic> topPosts = [];
  List<dynamic> searchResults = [];
  final TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() => isLoading = true);
    final links = await ApiService.getUsefulLinks();
    final posts = await ApiService.getTopPosts();
    setState(() {
      usefulLinks = links;
      topPosts = posts;
      isLoading = false;
    });
  }

  void searchTag() async {
    final tag = searchController.text.trim();
    if (tag.isEmpty) return;
    setState(() => isLoading = true);
    final results = await ApiService.searchPostsByTag(tag);
    setState(() {
      searchResults = results;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Top bar
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'community',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Useful links
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'useful links',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...usefulLinks.map(
                      (link) => ListTile(
                        title: Text(link['name']),
                        subtitle: Text(link['url']),
                        onTap: () => launchUrl(Uri.parse(link['url'])),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Questions section
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'questions section',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Search bar
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: const InputDecoration(
                              hintText: '태그로 검색...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: searchTag,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Search results
                    ...searchResults.map(
                      (post) => Card(
                        child: ListTile(
                          title: Text(post['title']),
                          subtitle: Text('태그: ${post['tags'].join(', ')}'),
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
                    const SizedBox(height: 8),
                    // Top posts
                    ...topPosts.map(
                      (post) => Card(
                        child: ListTile(
                          title: Text(post['title']),
                          trailing: const Icon(Icons.chevron_right),
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
                    const SizedBox(height: 8),
                    // Write new question
                    ListTile(
                      title: const Text('+ 질문하기!!'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const WriteQuestionPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
