import 'package:flutter/material.dart';
import 'package:invisibo_flutter/common/invisibo_circler_container.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InvisiboCirclerContainer(
            icon: const Icon(
              Icons.account_circle_rounded,
              size: 30,
            ),
            onPressed: (() => print('clicked profile icon!')),
          ),
          InvisiboCirclerContainer(
            icon: const Icon(
              Icons.question_answer_rounded,
              size: 30,
            ),
            onPressed: (() => print('clicked answers icon!')),
          ),
          InvisiboCirclerContainer(
            icon: const Icon(
              Icons.chat_bubble_rounded,
              size: 30,
            ),
            onPressed: (() => print('clicked chat icon!')),
          ),
        ],
      ),
    );
  }
}
