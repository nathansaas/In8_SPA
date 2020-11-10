import 'package:flutter/material.dart';
import 'package:in8_spa/Screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
      primaryColor: Colors.white,
      ),
      title: 'IN8',
      home: Scaffold(
        body: HomeScreen(),

      )
    );
  }
}