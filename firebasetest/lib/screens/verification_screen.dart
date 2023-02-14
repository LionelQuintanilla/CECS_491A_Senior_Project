import 'package:firebase_auth/firebase_auth.dart';

import '/components/custom_button.dart';
import '/core/authentication_service.dart';
import '/screens/login.dart';
import '/utils/loader.dart';
import '/screens/customer_support.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/core/authentication_service.dart';


class VerifyScreen extends StatelessWidget {
  const VerifyScreen({Key? key}) : super(key: key);
  static const String id = 'verify_screen';


  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          width: size.width,
          height: size.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0,right: 16.0, top: 50.0, bottom: 25.0),
              child: Form(
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
                      child:
                      Text(
                        'Verify',
                        style: TextStyle(
                          fontFamily: 'Cherry',
                          fontSize: 75,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Align(
                      child:
                      Text(
                        'Email',
                        style: TextStyle(
                          fontFamily: 'Cherry',
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Align(
                      child:
                      Text(
                        "Please verify your email before logging in. If you do not receive a verification email automatically, press the button below.",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Align(
                      child:
                      Text(
                        'Email: ${AuthenticationService.auth.currentUser!.email}',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 300,
                            height: 75,
                            child: OutlinedButton(
                              onPressed: () async{
                                //LoaderX.show(context);
                                AuthenticationService.auth.currentUser!.sendEmailVerification();
                                /*
                                while (AuthenticationService.auth.currentUser!.emailVerified == false) {
                                  AuthenticationService.auth.currentUser!.reload();
                                }
                                */
                                //LoaderX.hide();
                              },
                              child: const Text('Resend Email'),
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size.fromHeight(75),
                                shape: const StadiumBorder(),
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                side: const BorderSide(width: 5.0, color: Colors.black),
                                alignment: Alignment.center,
                                textStyle: const TextStyle( fontWeight: FontWeight.bold, fontSize: 40.0),
                              ),
                            ),
                          ),
                        )
                    ),
                    const SizedBox(height: 15),
                    Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 300,
                            height: 75,
                            child: OutlinedButton(
                              onPressed: () async {
                                Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (route) => false);
                              },
                              child: const Text('Log In'),
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size.fromHeight(75),
                                shape: const StadiumBorder(),
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                side: const BorderSide(width: 5.0, color: Colors.black),
                                alignment: Alignment.center,
                                textStyle: const TextStyle( fontWeight: FontWeight.bold, fontSize: 40.0),
                              ),
                            ),
                          ),
                        )
                    ),
                    const SizedBox(height:20),
                    GestureDetector(
                        onTap: () => Navigator.pushNamed(context, CustomerSupport.id),
                        child: Align(
                          alignment: Alignment.center,
                          child: RichText(
                            textScaleFactor: .9,
                            text: const TextSpan(
                                text: "Customer Support",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.black,
                                  fontSize: 30,
                                )
                            ),
                          ),
                        )
                    ),
                    const SizedBox(height:20),
                    GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Align(
                          alignment: Alignment.center,
                          child: RichText(
                            textScaleFactor: .9,
                            text: const TextSpan(
                                text: "Cancel",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.black,
                                  fontSize: 30,
                                )
                            ),
                          ),
                        )
                    )
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}

/*
const SizedBox(height: 10),
              Text(
                'Email: ${AuthenticationService.auth.currentUser!.email}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
 */
/*
SizedBox(
                width: 200,
                child: CustomButton(
                  label: 'Log In',
                  color: Colors.black,
                  onPressed: () async {
                    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (route) => false);
                  },
                  size: size,
                  textColor: Colors.white,
                  borderSide: BorderSide.none,
                ),
              )
 */
/*
SizedBox(
                width: 200,
                child: CustomButton(
                  label: 'Send Verification Email',
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
 */