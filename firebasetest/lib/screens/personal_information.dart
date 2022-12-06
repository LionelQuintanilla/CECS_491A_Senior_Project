
import 'package:firebasetest/screens/manage_accounts.dart';

import '../core/firebase_exceptions.dart';
import '/components/custom_button.dart';
import '/core/authentication_service.dart';
import '/screens/login.dart';
import '/utils/loader.dart';
import 'package:flutter/material.dart';
import '/screens/create_post.dart';
import '/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/utils/db_resources.dart';
import '/core/authentication_service.dart';

class PersonalInformation extends StatefulWidget {
  static const String id = 'personal_information';
  const PersonalInformation({Key? key}) : super(key: key);

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    final _key = GlobalKey<FormState>();
    final _authService = AuthenticationService();
    final _emailController = TextEditingController();
    final _usernameController = TextEditingController();
    _emailController.text = userEmail;
    _usernameController.text = userName;

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset('assets/images/backArrow.png',
                          height: 40,
                          width: 40)
                  ),
                  const SizedBox(height: 60),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Personal Information',
                      style: TextStyle(
                        fontSize: 60,
                        fontFamily: 'Cherry',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Email address',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                      controller: _emailController
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _usernameController,
                  ),
                  const SizedBox(height: 16),

                   OutlinedButton(
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        LoaderX.show(context);
                        final _status = await _authService.resetPassword(
                            email: _emailController.text.trim());
                        if (_status == AuthStatus.successful) {
                          LoaderX.hide();
                          Navigator.pushNamed(context, LoginScreen.id);
                        } else {
                          LoaderX.hide();
                          final error =
                          AuthExceptionHandler.generateErrorMessage(_status);
                        }
                      }
                    },
                       child: Text(
                         'Reset Password'
                       ),
                       style: OutlinedButton.styleFrom(
                   minimumSize: const Size.fromHeight(75),
              shape: const StadiumBorder(),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              side: const BorderSide(width: 5.0, color: Colors.black),
              alignment: Alignment.center,
              textStyle: const TextStyle( fontWeight: FontWeight.bold, fontSize: 35.0),
                  )
                   )],
              ),

            ),
          ),
        )
    );
  }
}
