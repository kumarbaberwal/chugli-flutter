import 'dart:convert';

import 'package:chugli/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  final String baseUrl = "http://localhost:6000/auth";

  Future<UserModel> login(
      {required String email, required String password}) async {
    final response = await http.post(Uri.parse('$baseUrl/login'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'});
    return UserModel.fromJson(jsonDecode(response.body));
  }
}
