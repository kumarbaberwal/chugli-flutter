import 'package:chugli/features/auth/presentation/widgets/auth_button.dart';
import 'package:chugli/features/auth/presentation/widgets/auth_input_fields.dart';
import 'package:chugli/features/auth/presentation/widgets/login_prompt.dart';
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
              AuthInputFields(
                hintText: "Username",
                iconData: Icons.person,
                controller: _usernameController,
              ),
              const SizedBox(
                height: 20,
              ),
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
                iconData: Icons.lock,
                controller: _passwordController,
                isPassword: true,
              ),
              const SizedBox(
                height: 20,
              ),
              AuthButton(
                text: "Register",
                onPressed: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              LoginPrompt(
                onTap: () {},
                title: "Already have an account? ",
                subtitle: "Click here to login",
              )
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
}
