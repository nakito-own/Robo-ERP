import 'package:flutter/material.dart';

class CustomAppBarButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomAppBarButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
