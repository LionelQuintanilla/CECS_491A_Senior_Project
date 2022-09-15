import 'package:firebase_auth/firebase_auth.dart';

import '/components/custom_button.dart';
import '/core/authentication_service.dart';
import '/screens/login.dart';
import '/utils/loader.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({Key? key}) : super(key: key);
  static const String id = 'verify_screen';


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/blank-dp.png'),
                  ),
                ),
              ),
              /*
              const SizedBox(height: 10),
              Text(
                'Hi, ${AuthenticationService.auth.currentUser!.displayName}.',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

               */
              const SizedBox(height: 10),
              const Text(
                'Please verify your email before logging in. If you did not automatically receive an email, press the button below',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Email: ${AuthenticationService.auth.currentUser!.email}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                width: 200,
                child: CustomButton(
                  label: 'SEND EMAIL',
                  color: Colors.black,
                  onPressed: () async {
                    //LoaderX.show(context);
                    AuthenticationService.auth.currentUser!.sendEmailVerification();
                    /*
                    while (AuthenticationService.auth.currentUser!.emailVerified == false) {
                      AuthenticationService.auth.currentUser!.reload();
                    }
                    */
                    //LoaderX.hide();
                  },
                  size: size,
                  textColor: Colors.white,
                  borderSide: BorderSide.none,
                ),
              ),
              SizedBox(
                width: 200,
                child: CustomButton(
                  label: 'LOGIN',
                  color: Colors.black,
                  onPressed: () async {
                    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (route) => false);
                  },
                  size: size,
                  textColor: Colors.white,
                  borderSide: BorderSide.none,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}