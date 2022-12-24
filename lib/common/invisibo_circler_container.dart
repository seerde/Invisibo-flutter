import 'package:flutter/material.dart';

class InvisiboCirclerContainer extends StatelessWidget {
  final Icon icon;
  final VoidCallback onPressed;

  const InvisiboCirclerContainer(
      {Key? key, required this.icon, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade600,
        borderRadius: BorderRadius.circular(90),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        enableFeedback: true,
        splashRadius: 1,
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}
