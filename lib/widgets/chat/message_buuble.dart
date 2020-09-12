import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  MessageBubble(this.message);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(color: Theme.of(context).accentColor,borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          margin: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
          child: Text(
            message,
            style: TextStyle(color: Theme.of(context).accentTextTheme.headline1.color),
          ),
        ),
      ],
    );
  }
}
