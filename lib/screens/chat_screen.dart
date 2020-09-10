import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/ChatScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Text('content'),
        ),
      ),
    );
  }
}