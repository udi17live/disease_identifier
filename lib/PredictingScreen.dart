import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disease_identifier/DiseasePage.dart';
import 'package:disease_identifier/models/Prediction.dart';
import 'package:disease_identifier/utils/DiseaseAPIHelper.dart';
import 'package:disease_identifier/widgets/DiseaseCard.dart';
import 'package:flutter/material.dart';

class PredictingScreen extends StatefulWidget {
  const PredictingScreen({Key? key, this.image_encoded = ''}) : super(key: key);

  final String image_encoded;

  @override
  State<PredictingScreen> createState() => _PredictingScreenState();
}

class _PredictingScreenState extends State<PredictingScreen> {
  @override
  Widget build(BuildContext context) {
    Future<List<Prediction>> getPredictionResult() async {
      var result = await DiseaseAPIHelper().getPrediction(widget.image_encoded);
      final jsonData = json.decode(result.body);
      final parsedPredictions = jsonData['result'].cast<Map<String, dynamic>>();

      return parsedPredictions
          .map<Prediction>((json) => Prediction.fromJson(json))
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Prediction Results",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
            size: 30,
          ),
          tooltip: 'About PepperMate',
          onPressed: () => Navigator.pop(context),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<List<Prediction>>(
            future: getPredictionResult(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Prediction>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('disease_data')
                            .where('slug',
                                isEqualTo:
                                    snapshot.data![index].name.toString())
                            .limit(1)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> dataSnap) {
                          if (dataSnap.connectionState ==
                              ConnectionState.waiting) {
                            return LinearProgressIndicator();
                          } else {
                            if (dataSnap.hasData) {
                              var docs = dataSnap.data!.docs;
                              var disease = docs[0].data()! as Map;
                              print(disease.runtimeType);
                              return ListTile(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DiseasePage(diseaseData: disease),
                                    )),
                                title: Text(disease['name']),
                                subtitle: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  strutStyle: StrutStyle(fontSize: 14.0),
                                  text: TextSpan(
                                      style: TextStyle(color: Colors.black),
                                      text: disease['description']),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(disease[
                                      'thumbnail']), // no matter how big it is, it won't overflow
                                ),
                                trailing: Text(
                                    snapshot.data![index].accuracy.toString()),
                              );
                            } else {
                              return Center(
                                  child: Text('Error: ${dataSnap.error}'));
                            }
                          }
                        },
                      );
                    },
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
