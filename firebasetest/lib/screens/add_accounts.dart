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

class AddAccounts extends StatelessWidget {
  const AddAccounts({Key? key}) : super(key: key);
  static const String id = 'add_accounts';

  @override
  Widget build(BuildContext context) {

    /* Returns the button for adding a Twitter account depending on if the user
    has a Twitter account linked to their user profile */
    Widget twitterConditional() {

      // Checks if the user has a Twitter account linked to their account
      if (hasTwitter == false) {
        return Container(
            margin: const EdgeInsets.only(bottom: 35.0),
            child: OutlinedButton.icon(
              // Redirects the user to first page of Twitter account process
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
            )
        );
      }
      else {
        /* If the user already has a Twitter account linked to their profile,
        an empty spaceholder widget is returned */
        return const SizedBox(height: 0);
      }
    }

    // Works the same as the "twitterConditional" widget. See above.
    Widget facebookConditional() {

      if (hasFacebook == false) {
        return Container(
            margin: const EdgeInsets.only(bottom: 35.0),
            child: OutlinedButton.icon(
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
            )
        );
      }
      else {
        return const SizedBox(height: 0);
      }
    }

    // Works the same as the "twitterConditional" widget. See above.
    Widget instagramConditional() {

      if (hasInstagram == false) {
        return Container(
            margin: const EdgeInsets.only(bottom: 35.0),
            child: OutlinedButton.icon(
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
            )
        );
      }
      else {
        return const SizedBox(height: 0);
      }
    }

    // Get the size of the current device's screen
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
                        // Returns the user to the last screen they visited
                        onTap: () => Navigator.pop(context),
                        child: Image.asset('assets/images/backArrow.png',
                            height: 40,
                            width: 40)
                    ),
                    const Align(
                        child:  Text(
                          'Add Accounts',
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
                      // Renders the result of the twitterConditional widget
                      child: twitterConditional()
                    ),
                    Container(
                      // Renders the result of the facebookConditional widget
                      child: facebookConditional()
                    ),
                    Container(
                      // Renders the result of the instagramConditional widget
                      child: instagramConditional()
                    )
                  ],
                ),
              ),
            )
        )
    );

  }


}