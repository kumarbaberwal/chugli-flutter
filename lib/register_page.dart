import 'dart:developer';

import 'package:chugli/core/theme.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextInput("Username", Icons.person, _usernameController),
              const SizedBox(
                height: 20,
              ),
              _buildTextInput("Email", Icons.email, _emailController),
              const SizedBox(
                height: 20,
              ),
              _buildTextInput("Password", Icons.password, _passwordController),
              const SizedBox(
                height: 20,
              ),
              _buildRegisterButton(context),
              const SizedBox(
                height: 20,
              ),
              _buildLoginPrompt(context),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {},
        child: RichText(
          text: const TextSpan(
              text: "Already have an account? ",
              style: TextStyle(color: Colors.grey),
              children: [
                TextSpan(
                    text: "Click here to login",
                    style: TextStyle(color: Colors.blue))
              ]),
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _showInputValues,
      style: ElevatedButton.styleFrom(
        backgroundColor: DefaultColors.buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        padding: const EdgeInsets.symmetric(vertical: 15),
      ),
      child: const Text(
        "Register",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildTextInput(
      String hintText, IconData iconData, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
          color: DefaultColors.sentMessageInput,
          borderRadius: BorderRadius.circular(25)),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Icon(
            iconData,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showInputValues() {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    log("username: $username, email : $email, password: $password");
  }
}
