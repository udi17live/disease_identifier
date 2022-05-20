import 'package:flutter/material.dart';

class DiseaseCard extends StatelessWidget {
  const DiseaseCard({Key? key, required this.diseaseData}) : super(key: key);

  final Map diseaseData;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 100,
        color: Colors.white,
        child: Row(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Expanded(
                  child: Image.network(diseaseData['thumbnail']),
                  flex: 2,
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ListTile(
                        title: Text(diseaseData['name']),
                        subtitle: RichText(
                          overflow: TextOverflow.ellipsis,
                          strutStyle: StrutStyle(fontSize: 14.0),
                          text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              text: diseaseData['description']),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: Text("PLAY"),
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          TextButton(
                            child: Text("ADD TO QUEUE"),
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              flex: 8,
            ),
          ],
        ),
      ),
      elevation: 8,
      margin: EdgeInsets.all(10),
    );
  }
}
