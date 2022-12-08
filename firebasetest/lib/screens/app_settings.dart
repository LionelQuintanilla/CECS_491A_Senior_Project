
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

import '/screens/personal_information.dart';


class AppSettings extends StatefulWidget {
  const AppSettings({Key? key}) : super(key: key);
  static const String id = 'app_settings';

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {

  @override
  Widget build(BuildContext context) {
    ///see if user is logged in, in order to retrieve information
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
                     Align (
                       alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset('assets/images/backArrow.png',
                            height: 40,
                            width: 40)
                    )
                    ),
                     const Align(
                        child:  Text(
                          'Account Settings',
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
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.settings,
                        size: 24.0,
                      ),
                      label: const Text('Display'),
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
                      onPressed: (){},
                      icon: const Icon(
                        Icons.settings,
                        size: 24.0,
                      ),
                      label: const Text('Language'),
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
                    OutlinedButton.icon(
                      onPressed: (){
                        Navigator.pushNamed(context, PersonalInformation.id);
                      },
                      icon: const Icon(
                        Icons.person,
                        size: 24.0,
                      ),
                      label: const Text('Personal Information'),
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
                  ],
                ),

              ),
            )
        )
    );
  }
}