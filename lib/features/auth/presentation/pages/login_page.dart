import 'package:flutter/material.dart';

import '../widgets/auth_button.dart';
import '../widgets/auth_input_fields.dart';
import '../widgets/login_prompt.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              AuthInputFields(
                hintText: "Email",
                iconData: Icons.email,
                controller: _emailController,
              ),
              const SizedBox(
                height: 20,
              ),
              AuthInputFields(
                hintText: "Password",
                iconData: Icons.password,
                controller: _passwordController,
                isPassword: true,
              ),
              const SizedBox(
                height: 20,
              ),
              AuthButton(
                text: "Login",
                onPressed: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              LoginPrompt(
                onTap: () {},
                title: "Don't have an account? ",
                subtitle: "Click here to Register",
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
