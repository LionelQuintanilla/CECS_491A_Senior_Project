import 'package:firebasetest/screens/home_screen.dart';
import 'package:firebasetest/utils/db_resources.dart';
import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '/screens/manage_accounts.dart';

class InstagramAdd2 extends StatefulWidget{
  static const String id = 'instagram_add_2';
  const InstagramAdd2({Key? key}) : super(key:key);

  @override
  State<InstagramAdd2> createState() => _InstagramAdd2();

}

class _InstagramAdd2 extends State<InstagramAdd2>{
  // final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  // String? _accessToken;
  // String? _refreshToken;

  @override
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }

  InAppWebViewController? _webViewController;

  String url = "";
  double progress = 0;
  bool enableHistory = true;

  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: Container(
            child: Column(children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text(
                    "CURRENT URL\n${(url.length > 50) ? "${url.substring(0, 50)}..." : url}"),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset('assets/images/backArrow.png',
                      height: 40,
                      width: 40)
              ),
              Container(
                  padding: EdgeInsets.all(10.0),
                  child: progress < 1.0
                      ? LinearProgressIndicator(value: progress)
                      : Container()),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                  child: InAppWebView(
                    initialUrlRequest:
                    URLRequest(url: Uri.parse("https://www.instagram.com/accounts/login/")),
                    onWebViewCreated: (InAppWebViewController controller) {
                      print("When the page first loads: " + this.url);
                      _webViewController = controller;
                    },
                    onLoadStart: (InAppWebViewController controller, Uri? url) {
                      setState(() {
                        this.url = url.toString();
                      });
                    },
                    onLoadStop: (InAppWebViewController controller, Uri? url) async {
                      setState(() {
                        this.url = url.toString();
                      });
                    },
                    onProgressChanged: (InAppWebViewController controller, int progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                    onUpdateVisitedHistory: (InAppWebViewController controller, Uri? url, enableHistory) async {
                      print("When the page finishes loading: " + this.url);
                      setState(() {
                        this.url = url.toString();
                      });
                      if (this.url == "https://www.instagram.com/") {
                        // This can also be used with https://www.instagram.com/accounts/onetap/?next=%2F
                        socialMediaAppName='instagram';
                        insertNewSocial();
                        print("WHAT IS YOUR MAJOR MALFUNCTION? DID MOMMY AND DADDY NOT LOVE YOU ENOUGH AS A CHILD?");
                        await getSocials();
                        print("UserID: " + userID + " UserEmail: " + userEmail + " AppName: " + socialMediaAppName);
                        Navigator.pushNamed(context, ManageAccounts.id);
                      }
                    },
                  ),
                ),
              )
            ])),
      ),
    );
  }
}