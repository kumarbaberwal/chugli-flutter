import 'package:flutter/material.dart';

class LoginPrompt extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String subtitle;
  const LoginPrompt({
    super.key,
    required this.onTap,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: RichText(
          text: TextSpan(
            text: title,
            style: const TextStyle(color: Colors.grey),
            children: [
              TextSpan(
                text: subtitle,
                style: const TextStyle(color: Colors.blue),
              )
            ],
          ),
        ),
      ),
    );
  }
}
