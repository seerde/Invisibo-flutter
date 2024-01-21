import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invisibo_flutter/common/my_activity_button.dart';
import 'package:invisibo_flutter/common/my_horizontal_rule.dart';
import 'package:vertical_tab_bar_view/vertical_tab_bar_view.dart';
import 'package:bottom_sheet/bottom_sheet.dart';

import 'my_card_view.dart';
import 'my_send_button.dart';
import 'my_text_field.dart';

class Message {
  final int id;
  final String text;
  final String date;
  final String author;
  final List<Reply> replies;

  Message(
      {required this.id,
      required this.text,
      required this.date,
      required this.author,
      required this.replies});

  factory Message.fromJson(Map<String, dynamic> json) {
    var list = json['replies'] as List;
    List<Reply> replyList = list.map((i) => Reply.fromJson(i)).toList();

    return Message(
      id: json['id'],
      text: json['text'],
      date: json['date'],
      author: json['author'],
      replies: replyList,
    );
  }
}

class Reply {
  final int id;
  final String text;
  final String date;
  final String author;

  Reply(
      {required this.id,
      required this.text,
      required this.date,
      required this.author});

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      id: json['id'],
      text: json['text'],
      date: json['date'],
      author: json['author'],
    );
  }
}

Future<List<Message>> loadMessages() async {
  String jsonString = await rootBundle.loadString('lib/common/testData.json');
  final jsonResponse = json.decode(jsonString);
  return jsonResponse['messages']
      .map<Message>((item) => Message.fromJson(item))
      .toList();
}

class MyBody extends StatefulWidget {
  const MyBody({super.key});

  @override
  State<MyBody> createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  bool _isConfirm = false;
  String _oldText = '';
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (_isConfirm && _controller.text != _oldText) {
      setState(() {
        _isConfirm = false;
      });
    }
    _oldText = _controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return VerticalTabBarView(children: [
      Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            MyTextField(
              controller: _controller,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MySendButton(
                    icon: Icons.brush,
                    size: 60,
                    onTap: () {
                      print("Brush");
                    },
                    border: false,
                  ),
                  _isConfirm
                      ? MySendButton(
                          icon: Icons.check,
                          size: 80,
                          onTap: () {
                            setState(() {
                              _isConfirm = false;
                            });
                          },
                          iconColor: Colors.blueGrey,
                          backgroundColor: Colors.amber.shade700,
                          border: false,
                        )
                      : MySendButton(
                          icon: Icons.maps_ugc,
                          size: 80,
                          onTap: () {
                            setState(() {
                              if (_controller.text.isNotEmpty &&
                                  _controller.text.length > 5) {
                                _isConfirm = true;
                              }
                            });
                          },
                          border: true,
                        ),
                  MySendButton(
                    icon: Icons.palette,
                    size: 60,
                    onTap: () {
                      print("Palette");
                    },
                    border: false,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      Center(
        child: FutureBuilder<List<Message>>(
          future: loadMessages(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Message>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return PageView(
                controller: PageController(viewportFraction: 1.0),
                scrollDirection: Axis.vertical,
                children: snapshot.data!.map((message) {
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomCardView(
                          cardDate: message.date,
                          cardText: message.text,
                        ),
                        MyActivityButton(
                          isActive: true,
                          notificationCount: 2,
                          onPressed: () {
                            showStickyFlexibleBottomSheet(
                              minHeight: 0,
                              initHeight: 0.5,
                              maxHeight: 1,
                              headerHeight: 80,
                              context: context,
                              bottomSheetColor: Colors.transparent,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                                color: Color.fromARGB(255, 42, 42, 42),
                              ),
                              headerBuilder:
                                  (BuildContext context, double offset) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: MyHorizontalRule(),
                                        ),
                                        Text(
                                          'Replies',
                                          style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                );
                              },
                              bodyBuilder:
                                  (BuildContext context, double offset) {
                                return SliverChildListDelegate(
                                    message.replies.map((reply) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: CustomCardView(
                                      cardDate: reply.date,
                                      cardText: reply.text,
                                      cardSize: 0.2,
                                    ),
                                  );
                                }).toList()
                                    // <Widget>[
                                    //   Padding(
                                    //     padding: const EdgeInsets.all(10.0),
                                    //     child: CustomCardView(
                                    //       cardDate: '27 Dec',
                                    //       cardText: 'You can do it',
                                    //       cardSize: 0.2,
                                    //     ),
                                    //   ),
                                    //   Padding(
                                    //     padding: const EdgeInsets.all(10.0),
                                    //     child: CustomCardView(
                                    //       cardDate: '28 Dec',
                                    //       cardText: 'You suck!',
                                    //       cardSize: 0.2,
                                    //     ),
                                    //   ),
                                    // ],
                                    );
                              },
                            );
                          },
                        )
                      ],
                    ),
                  );
                }).toList(),
              );
            }
          },
          // child: PageView(
          //   controller: PageController(viewportFraction: 1.0),
          //   scrollDirection: Axis.vertical,
          //   children: [
          //     Container(
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           CustomCardView(
          //             cardDate: '27 Dec',
          //             cardText:
          //                 'Hello World!✋🏽\nMy name is Seerde\nNice to meet you all!',
          //           ),
          //           MyActivityButton(
          //             isActive: true,
          //             notificationCount: 2,
          //             onPressed: () {
          //               showStickyFlexibleBottomSheet(
          //                 minHeight: 0,
          //                 initHeight: 0.5,
          //                 maxHeight: 1,
          //                 headerHeight: 80,
          //                 context: context,
          //                 bottomSheetColor: Colors.transparent,
          //                 decoration: const BoxDecoration(
          //                   borderRadius: BorderRadius.only(
          //                     topLeft: Radius.circular(20.0),
          //                     topRight: Radius.circular(20.0),
          //                   ),
          //                   color: Color.fromARGB(255, 42, 42, 42),
          //                 ),
          //                 headerBuilder: (BuildContext context, double offset) {
          //                   return Row(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     crossAxisAlignment: CrossAxisAlignment.center,
          //                     children: [
          //                       Column(
          //                         children: const [
          //                           Padding(
          //                             padding: EdgeInsets.all(12.0),
          //                             child: MyHorizontalRule(),
          //                           ),
          //                           Text(
          //                             'Replies',
          //                             style: TextStyle(
          //                               fontSize: 23,
          //                               fontWeight: FontWeight.w800,
          //                               color: Colors.white,
          //                             ),
          //                           )
          //                         ],
          //                       ),
          //                     ],
          //                   );
          //                 },
          //                 bodyBuilder: (BuildContext context, double offset) {
          //                   return SliverChildListDelegate(
          //                     <Widget>[
          //                       Padding(
          //                         padding: const EdgeInsets.all(10.0),
          //                         child: CustomCardView(
          //                           cardDate: '27 Dec',
          //                           cardText: 'You can do it',
          //                           cardSize: 0.2,
          //                         ),
          //                       ),
          //                       Padding(
          //                         padding: const EdgeInsets.all(10.0),
          //                         child: CustomCardView(
          //                           cardDate: '28 Dec',
          //                           cardText: 'You suck!',
          //                           cardSize: 0.2,
          //                         ),
          //                       ),
          //                     ],
          //                   );
          //                 },
          //               );
          //             },
          //           )
          //         ],
          //       ),
          //     ),
          //     Container(
          //       color: Colors.blue,
          //       child: Center(child: Text('Card 2')),
          //     ),
          //     Container(
          //       color: Colors.green,
          //       child: Center(child: Text('Card 3')),
          //     ),
          //     // Add more containers for more cards
          //   ],
          // ),
        ),
      )
    ]);
  }
}
