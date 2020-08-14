import 'package:flutter/material.dart';

class GramPost extends StatefulWidget {

  final post;

  GramPost(this.post);

  @override
  _GramPostState createState() => _GramPostState();
}

class _GramPostState extends State<GramPost> {
  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Semantics(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/gram-detail', arguments: post);
        },
        child: ListTile(
          title: Text(post['date'].toString()),
          trailing: Text(post['quantity'].toString(), style: 
            TextStyle(fontSize: 22)
          ),
        ),
      ),
      button: true,
      onTapHint: 'View post from ${post['date'].toString()} with ${post['quantity'].toString()} items',
    );
  }
}