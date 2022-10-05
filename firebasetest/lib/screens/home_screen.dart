import '/components/custom_button.dart';
import '/core/authentication_service.dart';
import '/screens/login.dart';
import '/utils/loader.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: const SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.only(
                left: 16.0, right: 16.0, top: 50.0, bottom: 25.0),
          child:  Align(
            child:  Text(
              'HOME',
              style: TextStyle(
                fontFamily: 'Cherry',
                fontSize: 70,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            )
          ),

          ),
        )
      )
    );
  }
}