import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            // revese list bottom top
            reverse: true,
            itemCount: docs.length,
            itemBuilder: (context, index) {
              return Container(
                child: Text(docs[index].data()['text'].toString()),
              );
            },
          ),
        );
      },
    );
  }
}
