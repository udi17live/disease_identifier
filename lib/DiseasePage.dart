import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DiseasePage extends StatefulWidget {
  const DiseasePage({Key? key, required this.diseaseData}) : super(key: key);

  final Map diseaseData;

  @override
  State<DiseasePage> createState() => _DiseasePageState();
}

class _DiseasePageState extends State<DiseasePage> {
  bool _hasCallSupport = false;
  Future<void>? _launched;
  String _phone = '';

  @override
  void initState() {
    super.initState();
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  Future<void> _launchUniversalLinkIos(Uri url) async {
    final bool nativeAppLaunchSucceeded = await launchUrl(
      url,
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
      );
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            floating: true,
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.green,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.diseaseData['name'],
                textScaleFactor: 1,
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              titlePadding: EdgeInsets.symmetric(vertical: 0, horizontal: 55.0),
              background: Image.network(
                widget.diseaseData['thumbnail'],
                fit: BoxFit.fill,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 2.0,
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Description: ".toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  RichText(
                                    strutStyle: StrutStyle(
                                        fontSize: 16.0, leading: 0.7),
                                    text: TextSpan(
                                        style: TextStyle(color: Colors.black),
                                        text:
                                            widget.diseaseData['description']),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 2.0,
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Solution: ".toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  RichText(
                                    strutStyle: StrutStyle(
                                        fontSize: 16.0, leading: 0.7),
                                    text: TextSpan(
                                        style: TextStyle(color: Colors.black),
                                        text: "N/A"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 2.0,
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Additional Contacts: ".toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  ListTile(
                                    onTap: () => setState(() {
                                      _launched = _launchUniversalLinkIos(Uri.parse(
                                          'https://www.google.com/maps/dir//FJ3R%2BW95+Central+Research+Station,+Department+of+Export+Agriculture,+Matale/@7.2223879,79.6853845,9z/data=!4m8!4m7!1m0!1m5!1m1!1s0x3ae35b320f4b54ab:0xe1b17d6735980d02!2m2!1d80.6409764!2d7.4547649'));
                                    }),
                                    leading: Icon(
                                      Icons.place,
                                      color: Colors.green,
                                    ),
                                    title: Text(
                                        "Central Research Station, Dept of Export Agriculture Matale, Sri Lanka"),
                                  ),
                                  ListTile(
                                    onTap: _hasCallSupport
                                        ? () => setState(() {
                                              _launched = _makePhoneCall(
                                                  '+94662222822');
                                            })
                                        : null,
                                    leading: Icon(
                                      Icons.phone,
                                      color: Colors.green,
                                    ),
                                    title: Text("+94 66 2 222 822"),
                                  ),
                                  ListTile(
                                    onTap: _hasCallSupport
                                        ? () => setState(() {
                                              _launched = _makePhoneCall(
                                                  '+94662231249');
                                            })
                                        : null,
                                    leading: Icon(
                                      Icons.phone,
                                      color: Colors.green,
                                    ),
                                    title: Text("+94 66 2 231 249"),
                                  ),
                                  ListTile(
                                    onTap: _hasCallSupport
                                        ? () => setState(() {
                                              _launched = _makePhoneCall(
                                                  '+94662222822');
                                            })
                                        : null,
                                    leading: Icon(
                                      Icons.fax,
                                      color: Colors.green,
                                    ),
                                    title: Text("+94 66 2 222 822"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
