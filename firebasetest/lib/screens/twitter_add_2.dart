import 'package:firebasetest/screens/verification_screen.dart';
import 'package:firebasetest/utils/db_resources.dart';

import '/components/custom_button.dart';
import '/components/custom_textfield.dart';
import '/components/snackbar.dart';
import '/core/authentication_service.dart';
import '/core/firebase_exceptions.dart';
import '/screens/login.dart';
import '/utils/loader.dart';
import '/utils/validator.dart';
import 'package:flutter/material.dart';

import 'package:twitter_api_v2/twitter_api_v2.dart';
import 'package:twitter_oauth2_pkce/twitter_oauth2_pkce.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '/screens/manage_accounts.dart';


import 'dart:async';
import 'dart:io';

class TwitterAdd2 extends StatefulWidget{
  static const String id = 'twitter_add_2';
  const TwitterAdd2({Key? key}) : super(key:key);

  @override
  State<TwitterAdd2> createState() => _TwitterAdd2();

}

class _TwitterAdd2 extends State<TwitterAdd2>{
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  String? _accessToken;
  String? _refreshToken;

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
              /*
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text(
                    "CURRENT URL\n${(url.length > 50) ? url.substring(0, 50) + "..." : url}"),
              ),
               */
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
                    URLRequest(url: Uri.parse("https://twitter.com/i/flow/login")),
                    onWebViewCreated: (InAppWebViewController controller) {
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
                      setState(() {
                        this.url = url.toString();
                      });
                      if (this.url == "https://mobile.twitter.com/home") {
                        getSocials();
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