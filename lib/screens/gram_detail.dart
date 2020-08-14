import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GramDetailScreen extends StatelessWidget {

  static const routeName = '/gram-detail';

  @override
  Widget build(BuildContext context) {
    final DocumentSnapshot post = ModalRoute.of(context).settings.arguments;
  
    return(
      Scaffold(
        appBar: AppBar(
          title: Text('Wasteagram')
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 40,),
              Text(post['date'], style: TextStyle(
                fontSize: 30
              )),
              SizedBox(height: 40,),
              Image.network(post['imageURL'], height: 200, width: 200),
              SizedBox(height: 40,),
              Text('${post['quantity']} Items', style: TextStyle(
                fontSize: 30
              )),
              SizedBox(height: 40,),
              Text('Latitude: ${post['latitude']}', style: TextStyle(
                fontSize: 24
              )),
              Text('Longitude: ${post['longitude']}', style: TextStyle(
                fontSize: 24
              )),
            ],
          )
        )
      )
    );
  }
}