import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:scorebord/page/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData.light(),
      home: Home(),
    );
  }
}
