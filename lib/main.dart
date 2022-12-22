import 'package:flutter/material.dart';
import 'package:invisibo_flutter/common/invisibo_circler_container.dart';
import 'package:vertical_tab_bar_view/vertical_tab_bar_view.dart';

void main() {
  runApp(const MyTestApp());
}

class MyTestApp extends StatelessWidget {
  const MyTestApp({super.key});

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
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
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
            ),
            body: const VerticalTabBarView(children: [
              Center(
                child: Text('TEST1'),
              ),
              Center(
                child: Text('TEST2'),
              )
            ]),
            bottomNavigationBar: const Padding(
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
            ),
          ),
        ),
      ),
    );
  }
}
