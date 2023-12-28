import 'package:flutter/material.dart';

class MySendButton extends StatefulWidget {
  final IconData icon;
  final double size;
  final Function onTap;
  final bool border;
  final Color backgroundColor;
  final Color iconColor;

  const MySendButton(
      {Key? key,
      required this.icon,
      required this.size,
      required this.onTap,
      this.border = true,
      this.backgroundColor = Colors.white,
      this.iconColor = Colors.blueGrey})
      : super(key: key);

  @override
  _MySendButtonState createState() => _MySendButtonState();
}

class _MySendButtonState extends State<MySendButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        border: widget.border
            ? Border.all(
                color: Colors.amber.shade700,
                width: 3,
              )
            : null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: AnimatedPadding(
        duration: Duration(milliseconds: 50),
        padding: _isPressed ? EdgeInsets.all(6.0) : EdgeInsets.all(3.0),
        child: GestureDetector(
          onTap: () {
            widget.onTap();
            setState(() {
              _isPressed = true;
            });

            Future.delayed(Duration(milliseconds: 100), () {
              setState(() {
                _isPressed = false;
              });
            });
          },
          onTapDown: (details) {
            setState(() {
              _isPressed = true;
            });
          },
          onTapUp: (details) {
            setState(() {
              _isPressed = false;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: _isPressed ? Colors.grey : widget.backgroundColor,
              borderRadius: BorderRadius.circular(_isPressed ? 15 : 15),
            ),
            child: Transform.rotate(
              angle: 0 * 3.14159 / 180,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(
                    begin: widget.size / 1.5,
                    end: _isPressed
                        ? (widget.size / 1.5) - 10
                        : widget.size / 1.5),
                duration: Duration(milliseconds: 100),
                builder: (BuildContext context, double size, Widget? child) {
                  return Icon(
                    widget.icon,
                    size: size,
                    color: widget.iconColor,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
