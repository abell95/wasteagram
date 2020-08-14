import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';

class NewGramScreen extends StatefulWidget {
  static const routeName = "/new-gram";

  @override
  _NewGramScreenState createState() => _NewGramScreenState();
}

class _NewGramScreenState extends State<NewGramScreen> {

  File image;

  void getImage() async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = image;
    });
  }

  void uploadPost() async {
    // upload image, get url
    // get number of items from form
    // create waste post model w/stuff
    // upload that sucker to firebase
    var location = await getLocationData();
    String time = DateFormat.yMMMMEEEEd().format(DateTime.now());
    print('${location.latitude} ${location.longitude}');
    print(time);
  }

  Future<LocationData> getLocationData() async {
    var locationService = Location();
    return await locationService.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return(
      Scaffold(
        appBar: AppBar(
          title: Text('New Post'),
        ),
        body: image == null ?
          Center(
            child: RaisedButton(
              child: Text('Select photo'),
              onPressed: () {
                getImage();
              }
            ),
          )
          :
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.file(image, height: 300, width: 300,),
                SizedBox(height: 40),
                // number of wasted items
                RaisedButton(
                  child: Text('Post photo'),
                  onPressed: () {
                    uploadPost();
                  }
                )
              ],
            ),
          )
      )
    );
  }
}