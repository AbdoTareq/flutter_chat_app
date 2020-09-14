import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String username;
  final String userImage;
  final bool isMe;
  final Key key;
  MessageBubble(this.message, this.username, this.userImage, this.isMe,
      {this.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                    color:
                        isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                    borderRadius: isMe
                        ? BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          )
                        : BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          )),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 26),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isMe
                              ? Colors.black
                              : Theme.of(context)
                                  .accentTextTheme
                                  .headline1
                                  .color),
                      textAlign: isMe ? TextAlign.end : TextAlign.start,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      message,
                      style: TextStyle(
                          color: isMe
                              ? Colors.black
                              : Theme.of(context)
                                  .accentTextTheme
                                  .headline1
                                  .color),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // this widget to fix image postion on messgae bubble
        Positioned(
            right: isMe ? 7 : null,
            left: isMe ? null : 7,
            bottom: -10,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userImage),
            ))
      ],
      overflow: Overflow.visible,
    );
  }
}
