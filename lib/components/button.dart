import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  VoidCallback pressed;
  Button({super.key, required this.label, required this.pressed});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: pressed,
      color: Colors.black,
      child: Text(
        label,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
