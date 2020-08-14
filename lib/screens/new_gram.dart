import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:uuid/uuid.dart';

import '../models/waste_post.dart';

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

  Future<dynamic> uploadImage() async {
    var uuid = Uuid();
    var id = uuid.v4();

    fs.StorageReference storageReference = fs.FirebaseStorage.instance.ref().child(id);
    fs.StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    return await storageReference.getDownloadURL();
  }

  void uploadPost(String numberItems) async {
    // upload that sucker to firebase
    var location = await getLocationData();
    String time = DateFormat.yMMMMEEEEd().format(DateTime.now());

    final url = await uploadImage();

    var wastePost = WastePost(
      numItems: int.parse(numberItems), 
      photoURL: url, 
      latitude: location.latitude, 
      longitude: location.longitude,
      datePosted: time
    );

    wastePost.validateLatLon();

    Firestore.instance.collection("posts").add({
      'quantity': wastePost.numItems,
      'imageURL': wastePost.photoURL,
      'latitude': wastePost.latitude,
      'longitude': wastePost.longitude,
      'date': wastePost.datePosted,
    });

    Navigator.of(context).pop();
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
            child: Semantics(
              child: RaisedButton(
                child: Text('Select photo'),
                onPressed: () {
                  getImage();
                }
              ),
              onTapHint: 'Select a photo from the gallery',
              enabled: true,
              button: true
            )
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
                      child: Semantics(
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
                        focused: true,
                        hint: 'Number of items wasted',
                        textField: true,
                      ),
                      width: 300),
                  SizedBox(height: 40),
                  Semantics(
                    child: RaisedButton(
                      child: Text('Post photo'),
                      onPressed: () {
                        if (formkey.currentState.validate()) {
                          formkey.currentState.save();
                        }
                      }
                    ),
                    button: true,
                    enabled: true,
                    onTapHint: 'Upload post to cloud',
                  )
              ],
            ),
          )
        )
      )
    );
  }
}
