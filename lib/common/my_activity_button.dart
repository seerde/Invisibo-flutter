import 'package:flutter/material.dart';

class MyActivityButton extends StatefulWidget {
  final Function onPressed;
  final int notificationCount;
  final bool isActive;
  const MyActivityButton(
      {Key? key,
      required this.onPressed,
      required this.notificationCount,
      required this.isActive})
      : super(key: key);

  @override
  State<MyActivityButton> createState() => _MyActivityButtonState();
}

class _MyActivityButtonState extends State<MyActivityButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.isActive ? 168 : 140,
      height: 50,
      child: AnimatedPadding(
        duration: Duration(milliseconds: 50),
        padding: _isPressed ? EdgeInsets.all(6.0) : EdgeInsets.all(3.0),
        child: GestureDetector(
          onTap: () {
            widget.onPressed();
            setState(() {
              _isPressed = true;
            });
            Future.delayed(Duration(milliseconds: 100), () {
              setState(() {
                _isPressed = false;
              });
            });
            print('Button tapped!');
          },
          onTapDown: (details) {
            setState(() {
              _isPressed = true;
            });
          },
          onTapUp: (details) {
            // widget.onPressed();
            setState(() {
              _isPressed = false;
            });
          },
          onLongPressEnd: (details) {
            widget.onPressed();
            setState(() {
              _isPressed = false;
            });
          },
          onHorizontalDragEnd: (details) {
            setState(() {
              _isPressed = false;
            });
          },
          onVerticalDragEnd: (details) {
            setState(() {
              _isPressed = false;
            });
          },
          child: Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  widget.isActive ? Icons.auto_fix_high : Icons.edit_off,
                  color: widget.isActive
                      ? Colors.amber.shade700
                      : Color.fromARGB(255, 148, 148, 148),
                ),
                Text(
                  widget.isActive ? "Replies" : 'No replies',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: widget.isActive
                        ? Colors.amber.shade700
                        : Color.fromARGB(255, 148, 148, 148),
                  ),
                ),
                if (widget.isActive)
                  CircleAvatar(
                    radius: _isPressed ? 14 : 16,
                    backgroundColor: Colors.amber.shade700,
                    child: Text(
                      widget.notificationCount > 99
                          ? '99+'
                          : '${widget.notificationCount}',
                      style: TextStyle(
                        fontSize: (widget.notificationCount > 99
                            ? (_isPressed ? 10 : 12)
                            : (_isPressed ? 15 : 18)),
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
