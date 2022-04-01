import 'package:disease_identifier/Home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pepper Plant Leaf Disease Identification System',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
