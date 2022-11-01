import 'package:firebasetest/screens/verification_screen.dart';

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


import 'dart:async';
import 'dart:io';

class TwitterAdd extends StatefulWidget{
  static const String id = 'twitter_add';
  const TwitterAdd({Key? key}) : super(key:key);

  @override
  State<TwitterAdd> createState() => _TwitterAdd();

}

class _TwitterAdd extends State<TwitterAdd>{
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  String? _accessToken;
  String? _refreshToken;

  @override
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          width: size.width,
          height: size.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0,right: 16.0, top: 50.0, bottom: 25.0),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset('assets/images/backArrow.png',
                            height: 40,
                            width: 40)
                    ),
                    const Align(
                      child:
                      Text(
                        'Add Twitter',
                        style: TextStyle(
                          fontFamily: 'Cherry',
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Align(
                      child:
                      Text(
                        'Account',
                        style: TextStyle(
                          fontFamily: 'Cherry',
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Align(
                      child:
                      Text(
                        "Clicking “Add” will take you to the sign-in page of the selected account. When you’re finished, the account will be automatically added.",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 35),
                    OutlinedButton.icon(
                      onPressed: () async {
                        const String twitterUrl = "https://twitter.com";
                        if (await canLaunchUrlString(twitterUrl)) {
                        await launchUrlString(twitterUrl);
                        }
                      },
                      icon: const Icon(
                        Icons.people,
                        size: 50.0,
                      ),
                      label: const Text('Twitter'),
                      style: OutlinedButton.styleFrom(
                        //Button size in order to take up the whole screen
                        minimumSize: const Size.fromHeight(100),
                        shape: const StadiumBorder(),
                        //colors
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        //width of the border for our button
                        side: const BorderSide(width: 5.0, color: Colors.black),
                        //centers text
                        alignment: Alignment.center,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 45.0),
                      ),
                    ),
                    const SizedBox(height:100),
                    GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Align(
                          alignment: Alignment.center,
                          child: RichText(
                            textScaleFactor: .9,
                            text: const TextSpan(
                                text: "Cancel",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.black,
                                  fontSize: 30,
                                )
                            ),
                          ),
                        )
                    )
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}