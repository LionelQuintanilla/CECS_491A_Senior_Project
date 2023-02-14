import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '/screens/manage_accounts.dart';

class SnapchatAdd extends StatefulWidget{
  static const String id = 'snapchat_add';
  const SnapchatAdd({Key? key}) : super(key:key);

  @override
  State<SnapchatAdd> createState() => _SnapchatAdd();

}

class _SnapchatAdd extends State<SnapchatAdd>{
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
        appBar: AppBar(
          title: const Text('InAppWebView Example'),
        ),
        body: Container(
            child: Column(children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text(
                    "CURRENT URL\n${(url.length > 50) ? url.substring(0, 50) + "..." : url}"),
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