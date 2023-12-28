import 'package:flutter/material.dart';
import 'common/my_app_bar.dart';
import 'common/my_body.dart';
import 'common/my_bottom_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
                colors: [Colors.blueGrey.shade700, Colors.blueGrey.shade900],
                radius: 0.8),
          ),
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: PreferredSize(
                    preferredSize: Size.fromHeight(80.0), child: MyAppBar()),
                body: MyBody(),
                bottomNavigationBar: MyBottomNavigationBar(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
