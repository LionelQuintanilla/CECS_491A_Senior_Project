import 'package:firebasetest/screens/add_accounts.dart';
import 'package:firebasetest/screens/home_screen.dart';

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
import '/screens/add_accounts.dart';
import '/screens/remove_accounts.dart';

class ManageAccounts extends StatelessWidget {
  const ManageAccounts({Key? key}) : super(key: key);
  static const String id = 'manage_accounts';

  @override
  Widget build(BuildContext context) {

    Widget twitterConditional() {
      if (hasTwitter == true) {
        return Container(
            margin: const EdgeInsets.only(bottom: 35.0),
            child: OutlinedButton.icon(
              onPressed: null,
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
        return const SizedBox(height: 0);
      }
    }

    Widget facebookConditional() {
      if (hasFacebook == true) {
        return Container(
            margin: const EdgeInsets.only(bottom: 35.0),
            child: OutlinedButton.icon(
              onPressed: null,
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

    Widget instagramConditional() {
      if (hasInstagram == true) {
        return Container(
            margin: const EdgeInsets.only(bottom: 35.0),
            child: OutlinedButton.icon(
              onPressed: null,
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
/*
    Widget snapchatConditional() {
      if (hasSnapchat == true) {
        return Container(
            margin: const EdgeInsets.only(bottom: 35.0),
            child: OutlinedButton.icon(
              onPressed: null,
              icon: const Icon(
                Icons.people,
                size: 40.0,
              ),
              label: const Text("SnapChat"),
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

 */

    Widget addAccountButton() {
      if (hasTwitter == false || hasFacebook == false || hasInstagram == false) {
        return Container(
            margin: const EdgeInsets.only(bottom: 35.0),
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pushNamed(context, AddAccounts.id),
              icon: const Icon(
                Icons.people,
                size: 40.0,
              ),
              label: const Text("Add Account"),
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
                    fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
            )
        );
      }
      else {
        return const SizedBox(height: 0);
      }
    }

    Widget removeAccountButton() {

      if (hasTwitter == true || hasFacebook == true || hasInstagram == true || hasSnapchat == true) {
        return Container(
            margin: const EdgeInsets.only(bottom: 35.0),
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pushNamed(context, RemoveAccounts.id),
              icon: const Icon(
                Icons.people,
                size: 40.0,
              ),
              label: const Text("Remove Account"),
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
                    fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
            )
        );
      }
      else {
        return const SizedBox(height: 0);
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
                        onTap: () => Navigator.pushNamed(context, HomeScreen.id),
                        child: Image.asset('assets/images/backArrow.png',
                            height: 40,
                            width: 40)
                    ),
                    const Align(
                        child:  Text(
                          'Manage Accounts',
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
                    Container(
                      child: facebookConditional()
                    ),
                    Container(
                      child: instagramConditional()
                    ),
                    Container(
                        child: addAccountButton()
                    ),
                    Container(
                        child: removeAccountButton()
                    )
                  ],
                ),

              ),
            )
        )
    );

  }


}