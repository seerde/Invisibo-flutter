import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;

  const MyTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 13,
      style: const TextStyle(
        fontSize: 24,
      ),
      decoration: InputDecoration(
        hintText: 'What\'s on your mind?',
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueGrey, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
