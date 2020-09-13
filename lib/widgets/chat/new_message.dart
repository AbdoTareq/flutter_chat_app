import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  TextEditingController _textController = TextEditingController();
  String _enteredMessage = '';
  
  _sendMessage() async {
    final _currentUser = FirebaseAuth.instance.currentUser;
    final _userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUser.uid)
        .get();
    print('dart mess: ${_userData.data()}');
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': Timeline.now,
      'userId': _currentUser.uid,
      'username': _userData.data()['username'],
      'userImage': _userData.data()['user_url'],
    });
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(labelText: 'Send message ...'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
              icon: Icon(Icons.send),
              onPressed:
                  _enteredMessage.trim().isNotEmpty ? _sendMessage : null)
        ],
      ),
    );
  }
}
