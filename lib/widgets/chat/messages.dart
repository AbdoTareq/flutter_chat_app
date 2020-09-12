import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widgets/chat/message_buuble.dart';

class Messages extends StatelessWidget {
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
            return MessageBubble(
              docs[index].data()['text'].toString(),
              docs[index].data()['userId'] == FirebaseAuth.instance.currentUser.uid,
              // this key to optimize updating messages 
              key: ValueKey(docs[index].id)
            );
          },
        );
      },
    );
  }
}
