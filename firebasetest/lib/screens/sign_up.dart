import 'package:firebasetest/screens/verification_screen.dart';

import '/components/custom_button.dart';
import '/components/custom_textfield.dart';
import '/components/snackbar.dart';
import '/core/authentication_service.dart';
import '/core/firebase_exceptions.dart';
import '/screens/login.dart';
import '/utils/loader.dart';
import '/utils/validator.dart';
import 'package:flutter/material.dart';

import 'customer_support.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signup_screen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _authService = AuthenticationService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 50.0, bottom: 25.0),
            child: Form(
              key: _key,
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
                  const Text(
                    'New Account',
                    style: TextStyle(
                      fontFamily: 'Cherry',
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  const Align(
                    alignment: Alignment.center,
                    child:  Text(
                    'Enter new account info:',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      ),
                    textAlign: TextAlign.right,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Align(
                    alignment: Alignment(-.9, -1),
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
                  const SizedBox(height: 5.0),
                  Container(
                    child: CustomTextField(
                      hintText: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) => Validator.validateEmail(value ?? ""),
                      controller: _emailController,
                    ),
                    decoration:const BoxDecoration(
                      boxShadow: [
                         BoxShadow(
                          color: Colors.grey,
                          blurRadius: 15,
                          offset: Offset(1, 5)
                        )
                      ]
                    ),
                  ),
                  const SizedBox( height: 16),
                  const Align(
                    alignment: Alignment(-.9,-1),
                    child:
                    Text(
                      'Username',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    child: CustomTextField(
                      hintText: 'Enter your username',
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value) =>
                          Validator.fullNameValidate(value ?? ""),
                      controller: _nameController,
                    ),
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 15,
                              offset: Offset(1, 5)
                          )
                        ]
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment(-.9, -1),
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
                  Container(
                    child: CustomTextField(
                      hintText: '******',
                      obscureText: true,
                      maxLength: 32,
                      keyboardType: TextInputType.visiblePassword,
                      textCapitalization: TextCapitalization.none,
                      controller: _passwordController,
                      validator: (value) =>
                          Validator.validatePassword(value ?? ""),
                    ),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 15,
                          offset: Offset(1, 5)
                        )
                      ]
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    child:  OutlinedButton(
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          LoaderX.show(context);
                          final _status = await _authService.createAccount(
                            email: _emailController.text.trim(),
                            password: _passwordController.text,
                            name: _nameController.text,
                          );

                          if (_status == AuthStatus.successful) {
                            LoaderX.hide();
                            Navigator.pushNamed(context, VerifyScreen.id);
                          } else {
                            LoaderX.hide();
                            final error =
                            AuthExceptionHandler.generateErrorMessage(
                                _status);
                            CustomSnackBar.showErrorSnackBar(
                              context,
                              message: error,
                            );
                          }
                        }
                      },
                      //Creates the text within the button
                      child: const Text('CREATE ACCOUNT'),
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

                    ),
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 15,
                              offset: Offset(1, 5)
                          )
                        ]
                    ),
                  ),

                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          textScaleFactor: .9,
                          text: const TextSpan(

                            text: "Already Have An Account? ",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                              fontSize: 20,

                            ),

                          ),
                        ),
                      ],
                    )
                  ),

                  //Creates the Customer Support Link
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: (){
                      //On tap needs to be programmed for backend to meet customer support
                      Navigator.pushNamed(context, CustomerSupport.id);
                    },
                      //Creates a row centered in the middle of the screen
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                            textScaleFactor: .9,
                            text: const TextSpan(
                                text: "Customer Support",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.black,
                                  fontSize: 20,
                                )
                            )
                        )
                      ],
                    )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}