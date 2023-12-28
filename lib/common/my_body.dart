import 'package:flutter/material.dart';
import 'package:invisibo_flutter/common/my_horizontal_rule.dart';
import 'package:vertical_tab_bar_view/vertical_tab_bar_view.dart';
import 'package:bottom_sheet/bottom_sheet.dart';

import 'my_card_view.dart';
import 'my_send_button.dart';
import 'my_text_field.dart';

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
        child: PageView(
          controller: PageController(viewportFraction: 1.0),
          scrollDirection: Axis.vertical,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomCardView(
                    title: 'Card 1',
                    imageUrl: 'https://via.placeholder.com/150',
                  ),
                  TextButton(
                    child: Text('Click'),
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
                        headerBuilder: (BuildContext context, double offset) {
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
                                  Text('data')
                                ],
                              ),
                            ],
                          );
                        },
                        bodyBuilder: (BuildContext context, double offset) {
                          return SliverChildListDelegate(
                            <Widget>[
                              ListTile(
                                leading: Icon(Icons.music_note),
                                title: Text('Music'),
                                onTap: () => {},
                              ),
                              ListTile(
                                leading: Icon(Icons.videocam),
                                title: Text('Video'),
                                onTap: () => {},
                              ),
                            ],
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(child: Text('Card 2')),
            ),
            Container(
              color: Colors.green,
              child: Center(child: Text('Card 3')),
            ),
            // Add more containers for more cards
          ],
        ),
      )
    ]);
  }
}
