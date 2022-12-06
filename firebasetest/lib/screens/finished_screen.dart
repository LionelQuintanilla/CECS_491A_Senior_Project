import 'package:firebasetest/utils/share_resources.dart';
import 'package:flutter/material.dart';
import '/screens/twitter_add.dart';
import '/screens/instagram_add.dart';
import '/screens/facebook_add.dart';
import '/screens/snapchat_add.dart';
import '/screens/create_post.dart';
import '/screens/home_screen.dart';

class FinishedScreen extends StatelessWidget {
  const FinishedScreen({Key? key}) : super(key: key);
  static const String id = 'finished_screen';

  @override
  Widget build(BuildContext context) {

    /* This widget checks if a post was submitted to Twitter, and if it was,
    returns the status of the post */
    Widget conditionalTwitterStatus() {
      /* Checks the status of the Twitter post. If the status is empty, there was
      no post submitted to Twitter and an empty placeholder is returned */
      if (twitterPostStatus == "") {
        return const SizedBox(height: 0);
      }
      else if (twitterPostStatus == "success") {
        /* If the post status is marked "success", a badge labelled "Twitter" is
        returned to indicate a Twitter post was successfully sent */
        return OutlinedButton.icon(
          onPressed: () => null,
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
      /* If the status is not empty and is not "success", then it assumes an
      error occurred and returns an empty placeholder */
      else {
        return const SizedBox(height: 0);
      }
    }

    // Works the same as the conditionalTwitterStatus() widget
    Widget conditionalFacebookStatus() {
      if (facebookPostStatus == "") {
        return const SizedBox(height: 0);
      }
      else if (facebookPostStatus == "success") {
        return OutlinedButton.icon(
          onPressed: () => Navigator.pushNamed(context, FacebookAdd.id),
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

    // Works the same as the conditionalTwitterStatus() widget
    Widget conditionalInstagramStatus() {
      if (instagramPostStatus == "") {
        return SizedBox(height: 0);
      }
      else if (instagramPostStatus == "success") {
        return OutlinedButton.icon(
          onPressed: () => Navigator.pushNamed(context, InstagramAdd.id),
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
        return SizedBox(height: 0);
      }
    }

    // Gets the size of the current device's screen
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            width: size.width,
            height: size.height,
            color: Colors.white,
            child:  SingleChildScrollView(
              child: Padding(
                padding:  const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 50.0, bottom: 25.0),
                child:  Column(
                  children: [
                    const Align(
                        child:  Text(
                          'Finished!',
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

                    const Text(
                      'The post was successfully posted to these apps:',
                      style: TextStyle(
                        fontFamily: 'Calibri',
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      )
                    ),

                    // apps that were logged into by user will show true
                    const SizedBox(height: 35),
                    // Renders the widget returned by the conditionalTwitterStatus() method
                    Container(child: conditionalTwitterStatus()),
                    const SizedBox(height: 35),
                    // Renders the widget returned by the conditionalFacebookStatus() method
                    Container(child: conditionalFacebookStatus()),
                    const SizedBox(height: 35),
                    // Renders the widget returned by the conditionalInstagramStatus() method
                    Container(child: conditionalInstagramStatus()),
                    const SizedBox(height: 35),
                    const Text(
                        'Want to post again?',
                        style: TextStyle(
                          fontFamily: 'Calibri',
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        )
                    ),
                    const SizedBox(height: 20),
                    /* If thus button is pressed, the user is sent back to the
                    post creation page */
                    OutlinedButton(
                      onPressed: () => Navigator.pushNamed(context, CreatePost.id),
                      child: const Text('Re-post'),
                    ),

                    const Text(
                        'Otherwise,',
                        style: TextStyle(
                          fontFamily: 'Calibri',
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        )
                    ),

                    const SizedBox(height: 20),
                    /* If this button is pressed, the user is sent to th home screen */
                    OutlinedButton(
                      onPressed: () => Navigator.pushNamed(context, HomeScreen.id),
                      child: const Text('Finish'),
                    ),
                  ],
                ),
              ),
            )
        )
    );
  }
}