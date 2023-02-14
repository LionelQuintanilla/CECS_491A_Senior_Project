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
import 'package:url_launcher/url_launcher.dart';

class CustomerSupport extends StatefulWidget{
  static const String id = 'support_screen';
  const CustomerSupport({Key? key}) : super(key:key);

  @override
  State<CustomerSupport> createState() => _CustomerSupport();

}

class _CustomerSupport extends State<CustomerSupport>{
  final _key = GlobalKey<FormState>();

  /* Controllers are used to handle text inputted into form fields. There are
  two form fields: one for the user's email, and another for the body of the
  customer service email. */
  final _emailController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  /* Used to format text inputs to URI parameters */
  String? encodeQueryParams(Map<String, String> params){
    return params.entries.
    map((MapEntry<String,String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

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
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    // Returns the user to the last page they visited
                    onTap: () => Navigator.pop(context),
                    child: Image.asset('assets/images/backArrow.png',
                           height: 40,
                           width: 40)
                  ),
                  const Align(
                    child:
                       Text(
                        'Customer',
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
                      'Support',
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
                      "Sorry to hear you're having trouble! Please leave your contact info and description of your issue, and we'll respond as soon as possible",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Align(
                    alignment: Alignment(-.9, -1),
                    child:
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    child: CustomTextField(
                      hintText: '',
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                      // Checks if the email the user inputs is valid
                      validator: (value) => Validator.validateEmail(value ?? ""),
                      // Saves the user's input to the email input controller
                      controller: _emailController,
                    )
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment(-.9, -1),
                    child:
                    Text(
                      'Issue Description',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextFormField(
                    minLines: 6,
                    maxLines: 15,
                    keyboardType: TextInputType.multiline,
                    // Saves the user's input to the email body controller
                    controller: _bodyController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.black, width: 5)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.black, width: 5)),
                      hintText: 'Enter description of your problem here',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
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
                          /* When the button is pressed, the URL Launcher widget is used to format an email to
                          the designated customer service email and sends it to the user's email application. */
                          onPressed: () async {
                            // Creates a URI link to the user's email application
                            Uri launchUri = Uri(
                              // Formats the URI as an email link
                              scheme: 'mailto',
                              // Sets the destination email
                              path: 'wuphffeedback@gmail.com',
                              // Sets the subject line and body of the email
                              query: encodeQueryParams(<String, String>{
                                'subject' : 'Wuphf Customer Feedback',
                                'body' : _bodyController.text,
                              }),
                            );
                            // Opens the URI link to the user's email application
                            await launchUrl(launchUri);
                          },
                          child: const Text('Submit'),
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
                    // Sends the user back to the last page they visited
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