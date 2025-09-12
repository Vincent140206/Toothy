import 'package:flutter/material.dart';

class ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const ControlButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      child: IconButton(
        icon: Icon(icon,
            color: backgroundColor == Colors.white
                ? Colors.black
                : Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}
