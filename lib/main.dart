import 'package:disease_identifier/Home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
