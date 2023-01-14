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
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(80.0),
                  child: AppBar(
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
                ),
                body: VerticalTabBarView(children: [
                  Center(
                    child: ListView(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      shrinkWrap: true,
                      children: [
                        TextField(
                          //scrollPadding: EdgeInsets.only(bottom: 40),
                          maxLines: 13,
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                          decoration: InputDecoration(
                            hintText: 'What\'s on your mind?',
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blueGrey, width: 2.0),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('data'),
                              Container(
                                decoration: BoxDecoration(
                                  // color: Colors.amber.shade700,
                                  border: Border.all(
                                    color: Colors.amber.shade700,
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () =>
                                            print('Clicked Send Button!'),
                                        icon: const Icon(
                                          Icons.send,
                                          size: 40,
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text('data')
                            ],
                          ),
                        )
                      ],
                    ),
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
        ),
      ),
    );
  }
}
