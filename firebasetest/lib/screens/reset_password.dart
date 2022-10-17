import '/components/custom_button.dart';
import '/components/custom_textfield.dart';
import '/components/snackbar.dart';
import '/core/authentication_service.dart';
import '/core/firebase_exceptions.dart';
import '/screens/login.dart';
import '/utils/loader.dart';
import '/utils/validator.dart';
import 'package:flutter/material.dart';
import '/screens/customer_support.dart';
import '/screens/sign_up.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String id = 'reset_password';
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _authService = AuthenticationService();

  @override
  void dispose() {
    _emailController.dispose();
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
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 50.0, bottom: 25.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                ),
                const SizedBox(height: 70),
                const Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 75,
                    fontFamily: 'Cherry',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 25),
                const Align(
                  child:
                  Text(
                    "If your email is in our system, you will be sent email with a link to reset your password.",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: 'abc@example.com',
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  controller: _emailController,
                  validator: (value) => Validator.validateEmail(value ?? ""),
                ),
                const SizedBox(height: 100),
                Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 300,
                        height: 75,
                        child: OutlinedButton(
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
                                CustomSnackBar.showErrorSnackBar(context,
                                    message: error);
                              }
                            }
                          },
                          child: const Text('Reset Password'),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(75),
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            side: const BorderSide(width: 5.0, color: Colors.black),
                            alignment: Alignment.center,
                            textStyle: const TextStyle( fontWeight: FontWeight.bold, fontSize: 35.0),
                          ),
                        ),
                      ),
                    )
                ),
                const SizedBox(height:35),
                GestureDetector(
                    onTap: () => Navigator.pushNamed(context, SignUpScreen.id),
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                        textScaleFactor: .9,
                        text: const TextSpan(
                            text: "Create a New Account",
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
                            ),
                        ),
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}