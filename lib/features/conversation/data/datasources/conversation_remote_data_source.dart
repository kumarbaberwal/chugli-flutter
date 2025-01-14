import 'dart:convert';
import 'dart:developer';

import 'package:chugli/features/conversation/data/models/conversation_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ConversationRemoteDataSource {
  final String baseUrl = "http://192.168.102.140:3000";
  final _storage = const FlutterSecureStorage();
  Future<String> checkOrCreateConversations({required String contactId}) async {
    final token = await _storage.read(key: 'token');
    final response = await http.post(
      Uri.parse('$baseUrl/conversations/check-or-create'),
      body: jsonEncode({'contactId': contactId}),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log(response.statusCode.toString());
    log(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['conversationId'];
    } else {
      throw Exception('Failed to check or create conversations');
    }
  }

  Future<List<ConversationModel>> fetchConversations() async {
    final token = await _storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('$baseUrl/conversations'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => ConversationModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch convesations');
    }
  }
}
