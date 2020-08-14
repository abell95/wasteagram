import 'dart:io';
import 'dart:convert';

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

  void uploadPost(String numberItems) async {
    // upload image, get url
    // create waste post model w/stuff
    // upload that sucker to firebase
    var location = await getLocationData();
    String time = DateFormat.yMMMMEEEEd().format(DateTime.now());
    print('${location.latitude} ${location.longitude}');
    print(time);
    print(int.parse(numberItems));
  }

  Future<LocationData> getLocationData() async {
    var locationService = Location();
    return await locationService.getLocation();
  }

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('New Post'),
        ),
        body: image == null
          ? Center(
            child: RaisedButton(
                child: Text('Select photo'),
                onPressed: () {
                  getImage();
                }
              ),
            )
          : Center(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Image.file(
                    image,
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(height: 40),
                  Container(
                      child: TextFormField(
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: 'Number of items',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (val) {
                          uploadPost(val);
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please add a number';
                          } else {
                            return null;
                          }
                        },
                      ),
                      width: 300),
                  SizedBox(height: 40),
                  RaisedButton(
                    child: Text('Post photo'),
                    onPressed: () {
                      if (formkey.currentState.validate()) {
                        formkey.currentState.save();
                      }
                    }
                  )
              ],
            ),
          )
        )
      )
    );
  }
}
