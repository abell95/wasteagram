import 'package:flutter/material.dart';

import './app.dart';
import './screens/gram_detail.dart';
import './screens/new_gram.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.grey[800],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark
      ),
      home: Wasteagram(title: 'Wasteagram'),
      routes: {
        NewGramScreen.routeName: (context) => NewGramScreen(),
        GramDetailScreen.routeName: (context) => GramDetailScreen(),
      }
    );
  }
}
