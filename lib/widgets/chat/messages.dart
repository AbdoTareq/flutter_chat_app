import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widgets/chat/message_bubble.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  void initState() {
    super.initState();
    // this line for ios permission configure for firebase messaging
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    //
    fbm.configure(
      onMessage: (msg) {
        print('dart mess: $msg');
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(msg.toString()),
        ));
        return;
      },
      onLaunch: (msg) {
        print('dart mess: $msg');
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(msg.toString()),
        ));
        return;
      },
      onResume: (msg) {
        print('dart mess: $msg');
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(msg.toString()),
        ));
        return;
      },
    );
    fbm.subscribeToTopic('chat');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final List<QueryDocumentSnapshot> docs = chatSnapshot.data.documents;
        return ListView.builder(
          // revese list bottom top
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (context, index) {
            print('dart mess: ${docs[index].data()}');

            return MessageBubble(
                docs[index].data()['text'].toString(),
                docs[index].data()['username'].toString(),
                docs[index].data()['userImage'].toString(),
                // this field represents isMe
                docs[index].data()['userId'] ==
                    FirebaseAuth.instance.currentUser.uid,
                // this key to optimize updating messages
                key: ValueKey(docs[index].id));
          },
        );
      },
    );
  }
}
