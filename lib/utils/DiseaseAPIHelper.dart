import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiseaseAPIHelper {
  String base_url = '10.0.2.2:5000';

  Future<http.Response> getPrediction(String image_encoded) async {
    var client = http.Client();
    try {
      var uri = Uri.http(base_url, '/predict-disease');
      var response = await client.post(uri,
          body: jsonEncode(<String, String>{
            "image_encoded": image_encoded,
          }));

      return response;
    } finally {
      client.close();
    }
  }

  String convertImageToBase64(File image) {
    final bytes = File(image.path).readAsBytesSync();

    return base64Encode(bytes);
  }
}
