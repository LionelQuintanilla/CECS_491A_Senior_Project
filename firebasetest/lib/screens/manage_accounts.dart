import '/components/custom_button.dart';
import '/core/authentication_service.dart';
import '/screens/login.dart';
import '/utils/loader.dart';
import 'package:flutter/material.dart';
import '/screens/create_post.dart';
import '/screens/manage_accounts.dart';
import '/screens/twitter_add.dart';

class ManageAccounts extends StatelessWidget {
  const ManageAccounts({Key? key}) : super(key: key);
  static const String id = 'manage_accounts';

  @override
  Widget build(BuildContext context) {
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
                          'Manage Accounts',
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
                    OutlinedButton.icon(
                      onPressed: () => Navigator.pushNamed(context, TwitterAdd.id),
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
                    ),
                    const SizedBox(height: 35),
                    OutlinedButton.icon(
                      onPressed: () => Navigator.pushNamed(context, ManageAccounts.id),
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
                    ),
                    const SizedBox(height: 35),
                    OutlinedButton.icon(
                      onPressed: (){},
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
                    ),
                    const SizedBox(height: 35),
                    OutlinedButton.icon(
                      onPressed: (){},
                      icon: const Icon(
                        Icons.people,
                        size: 24.0,
                      ),
                      label: const Text('Snapchat'),
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
                  ],
                ),

              ),
            )
        )
    );
  }
}