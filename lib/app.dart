import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './widgets/gram_post.dart';

class Wasteagram extends StatefulWidget {
  Wasteagram({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WasteagramState createState() => _WasteagramState();
}

class _WasteagramState extends State<Wasteagram> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("posts").snapshots(),
        builder: (content, snapshot) {
          if (snapshot.hasData && snapshot.data.documents.length != 0) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                var post = snapshot.data.documents[index];
                return GramPost(post);
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      ),
      floatingActionButton: Semantics(
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/new-gram');
          },
          child: Icon(Icons.camera_alt),
        ),
        button: true,
        enabled: true,
        onTapHint: 'Add a new post',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
