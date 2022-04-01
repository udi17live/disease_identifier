import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? image;

  Future pickLeafImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final tempImg = File(image.path);

      setState(() {
        this.image = tempImg;
      });
    } on PlatformException catch (e) {
      print('Failed to Pick Image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PepperMate".toUpperCase(),
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.info_outlined,
              color: Colors.green,
              size: 30,
            ),
            tooltip: 'About PepperMate',
            onPressed: () {},
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: image != null
                  ? Image.file(
                      image!,
                      width: 150,
                      height: 150,
                    )
                  : Container(
                      width: 150,
                      height: 150,
                      color: Colors.red,
                    ),
            ),
            SizedBox(
              width: 150.0,
              height: 150.0,
              child: ElevatedButton(
                onPressed: () => pickLeafImage(ImageSource.camera),
                child: Icon(
                  Icons.add_a_photo_outlined,
                  color: Colors.white,
                  size: 70.0,
                ),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  primary: Colors.green, // <-- Button color
                  onPrimary: Colors.greenAccent, // <-- Splash color
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("or"),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(10),
                primary: Colors.green, // <-- Button color
                onPrimary: Colors.greenAccent, // <-- Splash color
              ),
              onPressed: () => pickLeafImage(ImageSource.gallery),
              label: Text(
                "Select from Storage".toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              icon: Icon(
                Icons.image_outlined,
                size: 30.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
