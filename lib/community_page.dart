import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'chat_page.dart';
import 'api_service.dart';
import 'search_page.dart';
import 'warning_page.dart';
import 'community_page.dart';

class CommunityPage extends StatefulWidget {
  final String token;
  final String userId;

  const CommunityPage({super.key, required this.token, required this.userId});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  late IO.Socket socket;
  List<dynamic> users = [];
  List<String> onlineUsers = [];

  @override
  void initState() {
    super.initState();
    connectSocket();
    fetchUsers();
  }

  void connectSocket() {
    socket = IO.io('http://143.248.184.42:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      print('✅ SOCKET CONNECTED');
      socket.emit('userOnline', widget.userId);
    });

    socket.on('presenceUpdate', (data) {
      print('📡 PRESENCE UPDATE: $data');
      setState(() {
        onlineUsers = List<String>.from(data);
      });
    });

    socket.onDisconnect((_) => print('❌ SOCKET DISCONNECTED'));
  }

  void fetchUsers() async {
    try {
      final fetched = await ApiService.fetchCommunityUsers(widget.token);
      setState(() {
        users = fetched;
      });
    } catch (e) {
      print('❌ ERROR FETCHING USERS: $e');
    }
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  bool isUserOnline(String userId) {
    return onlineUsers.contains(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Community Chat',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Text('‼️', style: TextStyle(fontSize: 24)),
            tooltip: 'Warnings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WarningPage()),
              );
            },
          ),
          IconButton(
            icon: const Text('👥', style: TextStyle(fontSize: 24)),
            tooltip: 'Community',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      CommunityPage(token: widget.token, userId: widget.userId),
                ),
              );
            },
          ),
        ],
      ),
      body: users.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final userId = user['_id'];
                final username = user['username'] ?? 'Unknown';

                final isOnline = isUserOnline(userId);

                final location = user['location']?['coordinates'];
                final lat = location != null && location.length > 1
                    ? location[1].toStringAsFixed(4)
                    : 'N/A';
                final lng = location != null && location.length > 0
                    ? location[0].toStringAsFixed(4)
                    : 'N/A';

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isOnline ? Colors.green : Colors.grey,
                    child: Text(username[0].toUpperCase()),
                  ),
                  title: Text(username),
                  subtitle: Text('Location: ($lat, $lng)'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatPage(
                          userId: widget.userId,
                          otherUserId: userId,
                          otherUsername: username,
                          socket: socket,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Help / Search',
        child: const Icon(Icons.help_outline),
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
