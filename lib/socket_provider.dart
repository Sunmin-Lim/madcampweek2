// // // // import 'package:flutter/material.dart';
// // // // import 'package:socket_io_client/socket_io_client.dart' as IO;

// // // // class SocketProvider with ChangeNotifier {
// // // //   IO.Socket? _socket;
// // // //   bool _isConnected = false;
// // // //   String? _userId;

// // // //   bool get isConnected => _isConnected;
// // // //   IO.Socket? get socket => _socket;

// // // //   // 로그인 시 소켓 연결 초기화
// // // //   void initialize(String userId) {
// // // //     if (_socket != null && _isConnected) return; // 이미 연결된 상태에서 다시 연결하지 않음

// // // //     _userId = userId;
// // // //     _socket = IO.io('http://143.248.183.37:3001', {
// // // //       'transports': ['websocket'],
// // // //       'query': {'userId': userId},
// // // //     });

// // // //     // 연결 이벤트 핸들링
// // // //     _socket!.on('connect', (_) {
// // // //       // The underscore indicates the event is not used
// // // //       _isConnected = true;
// // // //       print('Socket connected for user: $_userId');
// // // //       notifyListeners();

// // // //       // 연결 시 서버로 메시지 전송
// // // //       _socket!.emit('message', 'Hello from Flutter!');
// // // //     });

// // // //     // 메시지 수신 이벤트
// // // //     _socket!.on('remainingSessions', (data) {
// // // //       print('Message from server: $data');
// // // //       // 수신된 메시지 처리 (UI 업데이트 등)
// // // //       notifyListeners();
// // // //     });

// // // //     // 연결 끊김 이벤트
// // // //     _socket!.on('disconnect', (_) {
// // // //       _isConnected = false;
// // // //       print('Socket disconnected');
// // // //       notifyListeners();
// // // //     });

// // // //     // 연결 시도
// // // //     _socket!.connect();
// // // //   }

// // // //   // 로그아웃 시 소켓 연결 해제
// // // //   void disconnect() {
// // // //     if (_socket != null) {
// // // //       _socket!.disconnect();
// // // //       _socket = null;
// // // //       _isConnected = false;
// // // //       notifyListeners();
// // // //     }
// // // //   }
// // // // }

// // // import 'dart:async';
// // // import 'package:flutter/material.dart';
// // // import 'package:socket_io_client/socket_io_client.dart' as IO;

// // // class SocketProvider with ChangeNotifier {
// // //   IO.Socket? _socket;
// // //   bool _isConnected = false;
// // //   String? _userId;
// // //   String _message = ''; // 수신된 메시지를 저장할 변수

// // //   bool get isConnected => _isConnected;
// // //   IO.Socket? get socket => _socket;
// // //   String get message => _message; // UI에서 메시지 사용

// // //   // 로그인 시 소켓 연결 초기화
// // //   void initialize(String userId) {
// // //     if (_socket != null && _isConnected) return; // 이미 연결된 상태에서 다시 연결하지 않음

// // //     _userId = userId;
// // //     _socket = IO.io('http://143.248.183.37:3001', {
// // //       'transports': ['websocket'],
// // //       'query': {'userId': userId},
// // //     });

// // //     // 연결 이벤트 핸들링
// // //     _socket!.on('connect', (_) {
// // //       _isConnected = true;
// // //       print('Socket connected for user: $_userId');
// // //       notifyListeners();

// // //       // 연결 시 서버로 메시지 전송
// // //       _socket!.emit('message', 'Hello from Flutter!');
// // //     });

// // //     // 메시지 수신 이벤트
// // //     _socket!.on('remainingSessions', (data) {
// // //       print('Message from server: $data');
// // //       _message = data['message'] ?? 'No message'; // 수신된 메시지 저장
// // //       notifyListeners(); // UI에 반영하기 위해 notifyListeners() 호출
// // //     });

// // //     // 연결 끊김 이벤트
// // //     _socket!.on('disconnect', (_) {
// // //       _isConnected = false;
// // //       print('Socket disconnected');
// // //       notifyListeners();
// // //     });

// // //     // 연결 시도
// // //     _socket!.connect();
// // //   }

// // //   // 로그아웃 시 소켓 연결 해제
// // //   void disconnect() {
// // //     if (_socket != null) {
// // //       _socket!.disconnect();
// // //       _socket = null;
// // //       _isConnected = false;
// // //       notifyListeners();
// // //     }
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:socket_io_client/socket_io_client.dart' as IO;

// // class SocketProvider with ChangeNotifier {
// //   IO.Socket? _socket;
// //   bool _isConnected = false;
// //   String? _userId;
// //   List<Map<String, dynamic>> _warnings = [];

// //   bool get isConnected => _isConnected;
// //   IO.Socket? get socket => _socket;
// //   List<Map<String, dynamic>> get warnings => _warnings;

// //   // 로그인 시 소켓 연결 초기화
// //   void initialize(String userId) {
// //     if (_socket != null && _isConnected) return; // 이미 연결된 상태에서 다시 연결하지 않음

// //     _userId = userId;
// //     _socket = IO.io('http://143.248.183.37:3001', {
// //       'transports': ['websocket'],
// //       'query': {'userId': userId},
// //     });

// //     // 연결 이벤트 핸들링
// //     _socket!.on('connect', (_) {
// //       _isConnected = true;
// //       print('Socket connected for user: $_userId');
// //       notifyListeners();
// //     });

// //     // 메시지 수신 이벤트
// //     _socket!.on('remainingSessions', (data) {
// //       print('Received remainingSessions: $data');
// //       // 수신된 데이터 처리: 리스트에 추가
// //       _warnings = List<Map<String, dynamic>>.from(data);
// //       notifyListeners(); // 화면 갱신
// //     });

// //     // 연결 끊김 이벤트
// //     _socket!.on('disconnect', (_) {
// //       _isConnected = false;
// //       print('Socket disconnected');
// //       notifyListeners();
// //     });

// //     // 연결 시도
// //     _socket!.connect();
// //   }

// //   // 로그아웃 시 소켓 연결 해제
// //   void disconnect() {
// //     if (_socket != null) {
// //       _socket!.disconnect();
// //       _socket = null;
// //       _isConnected = false;
// //       notifyListeners();
// //     }
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:socket_io_client/socket_io_client.dart' as IO;

// // class SocketProvider with ChangeNotifier {
// //   IO.Socket? _socket;
// //   bool _isConnected = false;
// //   String? _userId;
// //   List<Map<String, dynamic>> _warnings = []; // 데이터 리스트

// //   bool get isConnected => _isConnected;
// //   IO.Socket? get socket => _socket;
// //   List<Map<String, dynamic>> get warnings => _warnings;

// //   // 로그인 시 소켓 연결 초기화
// //   void initialize(String userId) {
// //     if (_socket != null && _isConnected) return; // 이미 연결된 상태에서 다시 연결하지 않음

// //     _userId = userId;
// //     _socket = IO.io('http://143.248.183.37:3001', {
// //       'transports': ['websocket'],
// //       'query': {'userId': userId},
// //     });

// //     // 연결 이벤트 핸들링
// //     _socket!.on('connect', (_) {
// //       _isConnected = true;
// //       print('Socket connected for user: $_userId');
// //       notifyListeners();
// //     });

// //     // 메시지 수신 이벤트
// //     _socket!.on('remainingSessions', (data) {
// //       print('Received remainingSessions: $data');
// //       // 새로운 데이터가 오면 기존 리스트에 추가
// //       if (data != null) {
// //         setWarnings(data);
// //       }
// //       notifyListeners();
// //     });

// //     // 연결 끊김 이벤트
// //     _socket!.on('disconnect', (_) {
// //       _isConnected = false;
// //       print('Socket disconnected');
// //       notifyListeners();
// //     });

// //     // 연결 시도
// //     _socket!.connect();
// //   }

// //   // 새로운 경고 메시지 처리
// //   void setWarnings(List<dynamic> newWarnings) {
// //     // 기존 warnings 리스트와 비교하여 새로운 데이터만 추가하거나 업데이트
// //     for (var warning in newWarnings) {
// //       bool exists = _warnings.any(
// //         (existing) => existing['repo_url'] == warning['repo_url'],
// //       );
// //       if (exists) {
// //         // 이미 존재하는 데이터는 업데이트, 예를 들어 remaining_time_ms를 갱신
// //         _warnings = _warnings.map((existing) {
// //           if (existing['repo_url'] == warning['repo_url']) {
// //             existing['remaining_time_ms'] = warning['remaining_time_ms'];
// //           }
// //           return existing;
// //         }).toList();
// //       } else {
// //         // 새 데이터를 추가
// //         _warnings.add(warning);
// //       }
// //     }
// //   }

// //   // 로그아웃 시 소켓 연결 해제
// //   void disconnect() {
// //     if (_socket != null) {
// //       _socket!.disconnect();
// //       _socket = null;
// //       _isConnected = false;
// //       notifyListeners();
// //     }
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class SocketProvider with ChangeNotifier {
//   IO.Socket? _socket;
//   bool _isConnected = false;
//   String? _userId;
//   List<Map<String, dynamic>> _warnings = [];

//   List<Map<String, dynamic>> get warnings => _warnings;

//   bool get isConnected => _isConnected;

//   // 로그인 시 소켓 연결 초기화
//   void initialize(String userId) {
//     if (_socket != null && _isConnected) return; // 이미 연결된 상태에서 다시 연결하지 않음

//     _userId = userId;
//     _socket = IO.io('http://143.248.183.37:3001', {
//       'transports': ['websocket'],
//       'query': {'userId': userId},
//     });

//     // 연결 이벤트 핸들링
//     _socket!.on('connect', (_) {
//       _isConnected = true;
//       print('Socket connected for user: $_userId');
//       notifyListeners();

//       // 연결 시 서버로 메시지 전송
//       _socket!.emit('message', 'Hello from Flutter!');
//     });

//     // 메시지 수신 이벤트
//     _socket!.on('remainingSessions', (data) {
//       print('Message from server: $data');
//       _handleNewWarning(data);
//       notifyListeners();
//     });

//     // 연결 끊김 이벤트
//     _socket!.on('disconnect', (_) {
//       _isConnected = false;
//       print('Socket disconnected');
//       notifyListeners();
//     });

//     // 연결 시도
//     _socket!.connect();
//   }

//   // 새로운 경고 메시지를 처리하고 일정 시간 후 삭제하는 로직
//   void _handleNewWarning(List<dynamic> data) {
//     for (var warning in data) {
//       _warnings.add(warning);

//       // 각 경고 메시지에 대해 5초 후 삭제하도록 타이머 설정
//       Timer(const Duration(seconds: 5), () {
//         _warnings.remove(warning); // 경고 메시지 삭제
//         notifyListeners(); // UI 갱신
//       });
//     }
//   }

//   // 로그아웃 시 소켓 연결 해제
//   void disconnect() {
//     if (_socket != null) {
//       _socket!.disconnect();
//       _socket = null;
//       _isConnected = false;
//       notifyListeners();
//     }
//   }
// }

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class SocketProvider with ChangeNotifier {
//   IO.Socket? _socket;
//   bool _isConnected = false;
//   String? _userId;
//   List<Map<String, dynamic>> _warnings = [];

//   List<Map<String, dynamic>> get warnings => _warnings;

//   bool get isConnected => _isConnected;

//   // 로그인 시 소켓 연결 초기화
//   void initialize(String userId) {
//     if (_socket != null && _isConnected) return; // 이미 연결된 상태에서 다시 연결하지 않음

//     _userId = userId;
//     _socket = IO.io('http://143.248.183.37:3001', {
//       'transports': ['websocket'],
//       'query': {'userId': userId},
//     });

//     // 연결 이벤트 핸들링
//     _socket!.on('connect', (_) {
//       _isConnected = true;
//       print('Socket connected for user: $_userId');
//       notifyListeners();

//       // 연결 시 서버로 메시지 전송
//       _socket!.emit('message', 'Hello from Flutter!');
//     });

//     // 메시지 수신 이벤트
//     _socket!.on('remainingSessions', (data) {
//       print('Message from server: $data');
//       _handleNewWarning(data);
//       notifyListeners();
//     });

//     // 연결 끊김 이벤트
//     _socket!.on('disconnect', (_) {
//       _isConnected = false;
//       print('Socket disconnected');
//       notifyListeners();
//     });

//     // 연결 시도
//     _socket!.connect();
//   }

//   // 새로운 경고 메시지를 처리하고 일정 시간 후 삭제하는 로직
//   void _handleNewWarning(List<dynamic> data) {
//     for (var warning in data) {
//       _warnings.add(warning);

//       // 각 경고 메시지에 대해 5초 후 삭제하도록 타이머 설정
//       Timer(const Duration(seconds: 6), () {
//         _warnings.remove(warning); // 경고 메시지 삭제
//         notifyListeners(); // UI 갱신
//       });
//     }
//   }

//   // 로그아웃 시 소켓 연결 해제
//   void disconnect() {
//     if (_socket != null) {
//       _socket!.disconnect();
//       _socket = null;
//       _isConnected = false;
//       notifyListeners();
//     }
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketProvider with ChangeNotifier {
  IO.Socket? _socket;
  bool _isConnected = false;
  String? _userId;
  List<Map<String, dynamic>> _warnings = [];

  List<Map<String, dynamic>> get warnings => _warnings;

  bool get isConnected => _isConnected;

  // 로그인 시 소켓 연결 초기화
  void initialize(String userId) {
    if (_socket != null && _isConnected) return; // 이미 연결된 상태에서 다시 연결하지 않음

    _userId = userId;
    _socket = IO.io('http://143.248.183.37:3001', {
      'transports': ['websocket'],
      'query': {'userId': userId},
    });

    // 연결 이벤트 핸들링
    _socket!.on('connect', (_) {
      _isConnected = true;
      print('Socket connected for user: $_userId');
      notifyListeners();

      // 연결 시 서버로 메시지 전송
      _socket!.emit('message', 'Hello from Flutter!');
    });

    // 메시지 수신 이벤트
    _socket!.on('remainingSessions', (data) {
      print('✅ Message from server: $data');

      _handleNewWarning(data);
      notifyListeners();
    });

    // 연결 끊김 이벤트
    _socket!.on('disconnect', (_) {
      _isConnected = false;
      print('Socket disconnected');
      notifyListeners();
    });

    // 연결 시도
    _socket!.connect();
  }

  // 새로운 경고 메시지를 처리하고 일정 시간 후 삭제하는 로직
  void _handleNewWarning(List<dynamic> data) {
    for (var warning in data) {
      // 기존 warnings 리스트에서 해당 repo_url을 가진 경고를 찾아서 업데이트
      int? existingWarningIndex = _warnings.indexWhere(
        (existing) => existing['repo_url'] == warning['repo_url'],
      );

      if (existingWarningIndex != -1) {
        // 이미 존재하는 repo_url이면 기존 데이터를 갱신
        _warnings[existingWarningIndex] = {
          ..._warnings[existingWarningIndex],
          'remaining_time_ms': warning['remaining_time_ms'],
          'timestamp': DateTime.now().millisecondsSinceEpoch, // 타임스탬프 갱신
        };
        // 기존의 타이머를 취소하고 새로 설정
        _restartTimerForWarning(_warnings[existingWarningIndex]);
      } else {
        // 새 데이터를 추가
        var newWarning = {
          'repo_url': warning['repo_url'],
          'remaining_time_ms': warning['remaining_time_ms'],
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        };
        _warnings.add(newWarning);
        _restartTimerForWarning(newWarning); // 타이머 설정
      }
    }
    notifyListeners();
  }

  // 경고 메시지에 대한 타이머 설정
  void _restartTimerForWarning(Map<String, dynamic> warning) {
    // 경고 메시지마다 6초 후에 자동으로 삭제되도록 설정
    Timer(Duration(seconds: 6), () {
      _warnings.remove(warning);
      notifyListeners(); // UI 갱신
    });
  }

  // 로그아웃 시 소켓 연결 해제
  void disconnect() {
    if (_socket != null) {
      _socket!.disconnect();
      _socket = null;
      _isConnected = false;
      notifyListeners();
    }
  }
}
