import 'package:flutter/material.dart';

import 'my_send_button.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 50),
      child: TabBar(
        enableFeedback: true,
        splashFactory: NoSplash.splashFactory,
        tabs: [
          Tab(
            icon: Icon(
              Icons.history_edu,
              size: 40,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.history,
              size: 40,
            ),
          ),
        ],
        indicator: BoxDecoration(),
      ),
    );
  }
}
