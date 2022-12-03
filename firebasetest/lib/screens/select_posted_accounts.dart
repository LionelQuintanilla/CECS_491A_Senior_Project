import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/components/custom_button.dart';
import '/core/authentication_service.dart';
import '/screens/login.dart';
import '/utils/loader.dart';
import 'package:flutter/material.dart';
import '/screens/create_post.dart';
import '/screens/manage_accounts.dart';
import '/screens/twitter_add.dart';
import '/screens/instagram_add.dart';
import '/screens/facebook_add.dart';
import '/screens/snapchat_add.dart';
import 'package:social_share_improvements_master/social_share.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:screenshot/screenshot.dart';
import '/screens/new_post_description.dart';
import '/utils/share_resources.dart';
import '/utils/db_resources.dart';
import '/screens/finished_screen.dart';

class SelectPostedAccounts extends StatefulWidget {
  const SelectPostedAccounts({Key? key}) : super(key: key);
  static const String id = 'select_posted_accounts';

  @override
  State<SelectPostedAccounts> createState() => _SelectPostedAccountsState();
}

class _SelectPostedAccountsState extends State<SelectPostedAccounts> {
  String facebookId = "300563532117789";

  var imageBackground = "image-background.jpg";
  var videoBackground = "video-background.mp4";
  String imageBackgroundPath = "";
  String videoBackgroundPath = "";

  @override
  void initState() {
    super.initState();
    copyBundleAssets();
  }

  Future<void> copyBundleAssets() async {
    imageBackgroundPath = await copyImage(imageBackground);
    videoBackgroundPath = await copyImage(videoBackground);
  }

  Future<String> copyImage(String filename) async {
    final tempDir = await getTemporaryDirectory();
    ByteData bytes = await rootBundle.load("assets/$filename");
    final assetPath = '${tempDir.path}/$filename';
    File file = await File(assetPath).create();
    await file.writeAsBytes(bytes.buffer.asUint8List());
    return file.path;
  }

  Future<String?> pickImage() async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    var path = file?.path;
    if (path == null) {
      return null;
    }
    return file?.path;
  }

  Future<String?> screenshot() async {
    var data = await screenshotController.capture();
    if (data == null) {
      return null;
    }
    final tempDir = await getTemporaryDirectory();
    final assetPath = '${tempDir.path}/temp.png';
    File file = await File(assetPath).create();
    await file.writeAsBytes(data);
    return file.path;
  }

  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    Widget conditionalTwitterPost() {
      if (hasTwitter == true) {
        return ElevatedButton.icon(
          onPressed: () async {
            twitterPostStatus = await SocialShare.shareTwitter(
              getDesc(),
              hashtags: [
                getHashtags()
              ],
              //url: "https://google.com/hello",
              trailingText: getTags(),
            );
            print('TWITTER STATUS: ' + twitterPostStatus!);
          },
          icon: const Icon(
            Icons.people,
            size: 24.0,
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
            textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
          ),
        );
      }
      else {
        return const SizedBox(height: 0);
      }
    }

    Widget conditionalFacebookPost() {
      if (hasFacebook == true) {
        return ElevatedButton.icon(
          onPressed: () async {
            var path = postImagePath;
            if (path == null) {
              return;
            }
            facebookPostStatus = await SocialShare.shareFacebookStory(
              appId: facebookId,
              imagePath: path,
              backgroundTopColor: "#ffffff",
              backgroundBottomColor: "#000000",
            );
            print('FACEBOOK STATUS: ' + facebookPostStatus!);
          },
          icon: const Icon(
            Icons.people,
            size: 24.0,
          ),
          label: const Text('Facebook'),
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
            textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
          ),
        );
      }
      else {
        return const SizedBox(height: 0);
      }
    }

    Widget conditionalInstagramPost() {
      if (hasInstagram == true) {
        return ElevatedButton.icon(
          onPressed: () async {
            var path = postImagePath;
            if (path == null) {
              return;
            }
            instagramPostStatus = await SocialShare.shareInstagramStory(
              appId: facebookId,
              imagePath: path,
              backgroundTopColor: "#ffffff",
              backgroundBottomColor: "#000000",
            );
            print('INSTAGRAM STATUS: ' + instagramPostStatus!);
          },
          icon: const Icon(
            Icons.people,
            size: 24.0,
          ),
          label: const Text('Instagram'),
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
            textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
          ),
        );
      }
      else {
        return const SizedBox(height: 0);
      }
    }

    return Scaffold(
        body: Container(
            width: size.width,
            height: size.height,
            color: Colors.white,
            child:  SingleChildScrollView(
              child: Padding(
                padding:  const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 50.0, bottom: 25.0),
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
                        child:  Text(
                          'Select Accounts',
                          style: TextStyle(
                            fontFamily: 'Cherry',
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        )
                    ),
                    const SizedBox(height: 35),
                    Container(child: conditionalTwitterPost()),
                    const SizedBox(height: 35),
                    Container(child: conditionalFacebookPost()),
                    const SizedBox(height: 35),
                    Container(child: conditionalInstagramPost()),
                    const SizedBox(height: 35),
                    OutlinedButton.icon(
                      onPressed: () => Navigator.pushNamed(context, FinishedScreen.id),
                      icon: const Icon(
                        Icons.people,
                        size: 24.0,
                      ),
                      label: const Text('Finish'),
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
                        textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
                      ),
                    )
                  ],
                ),

              ),
            )
        )
    );
  }
}