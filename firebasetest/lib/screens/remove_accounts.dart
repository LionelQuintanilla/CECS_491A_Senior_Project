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
import '/utils/db_resources.dart';

class RemoveAccounts extends StatelessWidget {
  const RemoveAccounts({Key? key}) : super(key: key);
  static const String id = 'remove_accounts';

  @override
  Widget build(BuildContext context) {

    Widget twitterConditional() {

      if (hasTwitter == true) {
        return OutlinedButton.icon(
          onPressed: () => Navigator.pushNamed(context, TwitterAdd.id),
          icon: const Icon(
            Icons.people,
            size: 40.0,
          ),
          label: const Text("Twitter"),
          style: OutlinedButton.styleFrom(
            //Button size in order to take up the whole screen
            minimumSize: const Size.fromHeight(90),
            shape: const StadiumBorder(),
            //colors
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            //width of the border for our button
            side: const BorderSide(width: 5.0, color: Colors.black),
            //centers text
            alignment: Alignment.center,
            textStyle: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 40.0),
          ),
        );
      }
      else {
        return const SizedBox(height: 35);
      }
    }

    Widget facebookConditional() {

      if (hasFacebook == true) {
        return OutlinedButton.icon(
          onPressed: () => Navigator.pushNamed(context, FacebookAdd.id),
          icon: const Icon(
            Icons.people,
            size: 40.0,
          ),
          label: const Text("Facebook"),
          style: OutlinedButton.styleFrom(
            //Button size in order to take up the whole screen
            minimumSize: const Size.fromHeight(90),
            shape: const StadiumBorder(),
            //colors
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            //width of the border for our button
            side: const BorderSide(width: 5.0, color: Colors.black),
            //centers text
            alignment: Alignment.center,
            textStyle: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 40.0),
          ),
        );
      }
      else {
        return const SizedBox(height: 35);
      }
    }

    Widget instagramConditional() {

      if (hasInstagram == true) {
        return OutlinedButton.icon(
          onPressed: () => Navigator.pushNamed(context, InstagramAdd.id),
          icon: const Icon(
            Icons.people,
            size: 40.0,
          ),
          label: const Text("Instagram"),
          style: OutlinedButton.styleFrom(
            //Button size in order to take up the whole screen
            minimumSize: const Size.fromHeight(90),
            shape: const StadiumBorder(),
            //colors
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            //width of the border for our button
            side: const BorderSide(width: 5.0, color: Colors.black),
            //centers text
            alignment: Alignment.center,
            textStyle: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 40.0),
          ),
        );
      }
      else {
        return const SizedBox(height: 35);
      }
    }

    Widget snapchatConditional() {

      if (hasSnapchat == true) {
        return OutlinedButton.icon(
          onPressed: () => Navigator.pushNamed(context, SnapchatAdd.id),
          icon: const Icon(
            Icons.people,
            size: 40.0,
          ),
          label: const Text("Snapchat"),
          style: OutlinedButton.styleFrom(
            //Button size in order to take up the whole screen
            minimumSize: const Size.fromHeight(90),
            shape: const StadiumBorder(),
            //colors
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            //width of the border for our button
            side: const BorderSide(width: 5.0, color: Colors.black),
            //centers text
            alignment: Alignment.center,
            textStyle: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 40.0),
          ),
        );
      }
      else {
        return const SizedBox(height: 35);
      }
    }

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
                          'Remove Accounts',
                          style: TextStyle(
                            fontFamily: 'Cherry',
                            fontSize: 65,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        )
                    ),
                    const SizedBox(height: 35),
                    Container (
                      child: twitterConditional()
                    ),
                    const SizedBox(height: 35),
                    Container(
                      child: facebookConditional()
                    ),
                    const SizedBox(height: 35),
                    Container(
                      child: instagramConditional()
                    ),
                    const SizedBox(height: 35),
                    Container(
                      child: snapchatConditional()
                    ),
                  ],
                ),

              ),
            )
        )
    );

  }


}