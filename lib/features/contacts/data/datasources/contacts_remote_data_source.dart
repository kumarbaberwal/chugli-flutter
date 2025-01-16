import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:vibematch/features/contacts/data/models/contacts_model.dart';

class ContactsRemoteDataSource {
  final String baseUrl = 'http://192.168.226.140:3000';
  final _storage = FlutterSecureStorage();

  Future<void> addContact({required String email}) async {
    final token = await _storage.read(key: 'token');
    final response = await http.post(
      Uri.parse('$baseUrl/contacts'),
      body: jsonEncode({'contactEmail': email}),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add contact');
    }
  }

  Future<List<ContactsModel>> fetchContacts() async {
    final token = await _storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('$baseUrl/contacts'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      return data.map((json) => ContactsModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch contacts');
    }
  }
}
