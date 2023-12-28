import 'package:flutter/material.dart';

class CustomCardView extends StatelessWidget {
  final String title;
  final String imageUrl;

  CustomCardView(
      {this.title = "Default Title",
      this.imageUrl = "https://via.placeholder.com/150"});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: <Widget>[
            Image.network(imageUrl),
            Text(title),
          ],
        ),
      ),
    );
  }
}
