import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/utils/db_resources.dart';

import '/components/custom_button.dart';
import '/components/custom_textfield.dart';
import '/components/snackbar.dart';
import '/core/authentication_service.dart';
import '/core/firebase_exceptions.dart';
import '/screens/home_screen.dart';
import '/screens/reset_password.dart';
import '/screens/sign_up.dart';
import '/screens/verification_screen.dart';
import '/utils/loader.dart';
import '/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

int logOutState = 0;

class _LoginScreenState extends State<LoginScreen> {

  late StreamSubscription<User?> user;

  void initState() {
    super.initState();

    checkManualLogout();

    print("CURRENT LOGOUT STATE: " + logOutState.toString());

    user = FirebaseAuth.instance.authStateChanges().listen((user) {

      if (user == null) {
        print('NO USER FOUND. PROCEED TO LOGIN.');
      }
      else {
        if (logOutState == 1) {
          print ('MANUAL LOGOUT. PROCEED TO LOGIN. CHECK VALUE: ' + logOutState.toString());
          clearPersistentUser();
        }
        else {
          print('USER FOUND. PROCEED TO HOME SCREEN.');
          print(user.displayName);
          userName = user.displayName!;
          print(user.email);
          userEmail = user.email!;
          getUserIDAsyncWrapper();
          Navigator.pushNamed(context, HomeScreen.id);
        }
      }
    });
  }

  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthenticationService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void clearPersistentUser() {
    user.cancel();
  }

  Timer? countdownTimer;
  Duration myDuration = Duration(minutes: 2);

  /// Timer related methods ///
  // Step 3
  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }
  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }
  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(minutes: 2));
  }
  // Step 6
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  int failedLogins = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: size.width,
          height: size.height,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 0, bottom: 25.0),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close),
                  ),*/
                  const SizedBox(height: 60),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'WUFPH',
                      style: TextStyle(
                        fontSize: 100,
                        fontFamily: 'Cherry',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child:Container(
                      child: Image.asset('assets/images/wuphf.jpg',
                          ),
                      height: 225.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment(-.9,-1),
                    child:
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: 'abc@example.com',
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    validator: (value) => Validator.validateEmail(value ?? ""),
                    controller: _emailController,
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment(-.9,-1),
                    child:
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: '********',
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    maxLength: 32,
                    controller: _passwordController,
                    textCapitalization: TextCapitalization.none,
                  ),
                  const SizedBox(height: 16),
                  Row(
                      children: [
                        const Spacer(),
                        Container(
                          width: 225,
                          child:
                          OutlinedButton(
                    onPressed: () async {
                      if (myDuration == Duration(minutes: 2) || myDuration == Duration(seconds: 0)){

                        if (myDuration == Duration(seconds: 0)) {
                          resetTimer();
                        }

                        if (_key.currentState!.validate()) {
                          LoaderX.show(context);
                          final _status = await _authService.login(
                            email: _emailController.text.trim(),
                            password: _passwordController.text,
                          );

                          if (_status == AuthStatus.successful) {

                            userEmail = _emailController.text.trim();
                            userID = await getUser();
                            getSocials();

                            LoaderX.hide();
                            if (AuthenticationService.auth.currentUser!
                                .emailVerified == true) {
                              Navigator.pushNamed(context, HomeScreen.id);
                            }
                            else {
                              Navigator.pushNamed(context, VerifyScreen.id);
                            }
                          }
                          else {
                            LoaderX.hide();
                            failedLogins += 1;
                            final error =
                            AuthExceptionHandler.generateErrorMessage(_status);
                            CustomSnackBar.showErrorSnackBar(
                              context,
                              message: (error + " Login attemps left: " +
                                  (5 - failedLogins).toString()),
                            );
                            if (failedLogins == 5) {
                              failedLogins = 0;
                              startTimer();
                            }
                          }
                        }
                      }
                      else {
                        CustomSnackBar.showErrorSnackBar(
                          context,
                          message: ("Max login attempts reached. Please try again in " + myDuration.inSeconds.toString() + " seconds."),
                        );
                      }
                    },
                    //Button style, outlined to match our figma
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
                      ),
                    child: const Text('LOGIN'),
                          ),
                        ),
                        const Spacer()
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                  ),
                  const SizedBox(height: 29),
                  Align(
                    alignment: Alignment.center,
                    child:
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, SignUpScreen.id),
                      child: RichText(
                        text: const TextSpan(
                          text: "Create New Account",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child:
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, ResetPasswordScreen.id),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 0.0),
                      ),
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }



}

Future<void> checkManualLogout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool CheckValue = prefs.containsKey('logout');
  print('LOGOUT KEY PRESENT IN STORAGE: ' + CheckValue.toString());
  logOutState = await prefs.getInt('logout') ?? 0;
  print('PERSISTENT STORAGE VALUE CHECK: ' + logOutState.toString());
}

Future<void> getUserIDAsyncWrapper() async {
  userID = await getUser();
  print(userID);
  getSocials();
}