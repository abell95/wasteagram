import 'package:flutter/material.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/new-gram');
        },
        child: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
