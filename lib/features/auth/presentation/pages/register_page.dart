import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibematch/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vibematch/features/auth/presentation/bloc/auth_event.dart';
import 'package:vibematch/features/auth/presentation/bloc/auth_state.dart';
import 'package:vibematch/features/auth/presentation/widgets/auth_button.dart';
import 'package:vibematch/features/auth/presentation/widgets/auth_input_fields.dart';
import 'package:vibematch/features/auth/presentation/widgets/login_prompt.dart';

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
              BlocConsumer<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return AuthButton(
                    text: "Register",
                    onPressed: _onRegister,
                  );
                },
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/conversationPage',
                      (route) => false,
                    );
                  }
                  if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              LoginPrompt(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
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

  void _onRegister() {
    BlocProvider.of<AuthBloc>(context).add(
      RegisterEvent(
        username: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
