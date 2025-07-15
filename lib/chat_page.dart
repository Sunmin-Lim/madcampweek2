import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  final String userId;
  final String otherUserId;
  final String otherUsername;
  final IO.Socket socket;

  const ChatPage({
    super.key,
    required this.userId,
    required this.otherUserId,
    required this.otherUsername,
    required this.socket,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  final List<Map<String, dynamic>> messages = [];

  late String roomId;

  @override
  void initState() {
    super.initState();
    roomId = _generateRoomId(widget.userId, widget.otherUserId);

    widget.socket.emit('joinRoom', roomId);

    widget.socket.on('receiveMessage', (data) {
      if (mounted) {
        setState(() {
          messages.add({'sender': data['senderId'], 'text': data['message']});
        });
      }
    });
  }

  String _generateRoomId(String a, String b) {
    return (a.compareTo(b) < 0) ? '$a-$b' : '$b-$a';
  }

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final messageData = {
      'roomId': roomId,
      'message': text,
      'senderId': widget.userId,
    };

    widget.socket.emit('sendMessage', messageData);

    setState(() {
      messages.add({'sender': widget.userId, 'text': text});
      messageController.clear();
    });
  }

  @override
  void dispose() {
    widget.socket.off('receiveMessage');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.otherUsername),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isMine = msg['sender'] == widget.userId;
                return Align(
                  alignment: isMine
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: isMine
                          ? Colors.blue.shade100
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(msg['text']),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
