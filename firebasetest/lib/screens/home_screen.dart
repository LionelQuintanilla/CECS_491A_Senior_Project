import 'package:firebasetest/screens/manage_accounts.dart';

import '/components/custom_button.dart';
import '/core/authentication_service.dart';
import '/screens/login.dart';
import '/utils/loader.dart';
import 'package:flutter/material.dart';
import '/screens/create_post.dart';
import '/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/utils/db_resources.dart';

import '/screens/app_settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final _authService = AuthenticationService();
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
                    'Home',
                    style: TextStyle(
                      fontFamily: 'Cherry',
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  )
              ),
              const SizedBox(height: 60),
              OutlinedButton.icon(
                onPressed: () => Navigator.pushNamed(context, CreatePost.id),
                icon: const Icon(
                  Icons.add,
                  size: 24.0,
                ),
                label: const Text('Create a Post'),
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
              ),
              const SizedBox(height: 60),
              OutlinedButton.icon(
                onPressed: () => {
                  Navigator.pushNamed(context, ManageAccounts.id),
                },
                icon: const Icon(
                  Icons.person,
                  size: 24.0,
                ),
                label: const Text('Manage Accounts'),
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
              ),
              const SizedBox(height: 60),
              OutlinedButton.icon(
                onPressed: () => {
                  Navigator.pushNamed(context, AppSettings.id),
                },
                  icon: const Icon(
                    Icons.settings,
                    size: 24.0,
                  ),
                  label: const Text('App Settings'),
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
              ),
              const SizedBox(height: 65),
              OutlinedButton(
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setInt('logout', 1);
                    await _authService.logout();
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  child: const Text(
                      'Log Out',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                  ),
                  style: OutlinedButton.styleFrom(
                    //Button size in order to take up the whole screen
                    minimumSize: const Size.fromHeight(75),
                    shape: const StadiumBorder(),
                    //colors
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    //width of the border for our button
                    side: const BorderSide(width: 5.0, color: Colors.black),
                    //centers text
                    alignment: Alignment.center,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
                  )
              )
            ],
          ),

          ),
        )
      )
    );
  }
}