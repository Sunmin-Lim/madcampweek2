import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;
  bool isConnected = false;

  static const String auto_serverIp = 'http://143.248.183.37:3001';

  void connect(String userId) {
    socket = IO.io('$auto_serverIp', <String, dynamic>{
      'transports': ['websocket'],
      'query': {'userId': userId},
    });

    socket.onConnect((_) {
      isConnected = true;
      print('Socket connected');
    });

    socket.on('remainingSessions', (data) {
      print('Received remainingSessions: $data');
      // TODO: 여기서 알림 띄우기 또는 UI 업데이트 처리
    });

    socket.onDisconnect((_) {
      isConnected = false;
      print('Socket disconnected');
    });
  }

  void disconnect() {
    socket.dispose();
  }
}
