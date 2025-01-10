import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  late IO.Socket _socket;

  final _storage = FlutterSecureStorage();
  factory SocketService() => _instance;

  SocketService._internal() {
    initSocket();
  }

  Future<void> initSocket() async {
    final token = await _storage.read(key: 'token');
    _socket = IO.io(
      'http://192.168.226.140:3000',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders({'Authorization': 'Bearer $token'})
          .build(),
    );

    _socket.connect();

    _socket.onConnect((_) {
      log('Socket connected: ${_socket.id}');
    });

    _socket.onDisconnect((_) {
      log('Socket disconnected: ${_socket.id}');
    });
  }


  IO.Socket get socket => _socket;
}
