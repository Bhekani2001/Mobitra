import 'package:flutter/material.dart';

class AppTextLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;

  const AppTextLink({
    super.key,
    required this.text,
    required this.onTap,
    this.color = Colors.deepPurple,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
