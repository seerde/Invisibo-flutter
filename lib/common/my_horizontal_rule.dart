import 'package:flutter/material.dart';

class MyHorizontalRule extends StatelessWidget {
  const MyHorizontalRule({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: 80,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 155, 155, 155),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: Colors.black),
      ),
      child: const Text(''),
    );
  }
}
