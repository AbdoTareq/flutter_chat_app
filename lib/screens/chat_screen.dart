import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
        body: FutureBuilder(
      future: Firebase.initializeApp(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return    StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chats/GSqttGEYaWLoDMm00AQL/messages')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final List<QueryDocumentSnapshot> docs = snapshot.data.documents;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Text(docs[index].data()['text'].toString()),
                    );
                  },
                );
              })
      ;
          },
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {}));
  }

  void firbaseCall() async {
    await Firebase.initializeApp();
  }
}
