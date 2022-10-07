import 'package:firebasetest/screens/verification_screen.dart';
import '/components/custom_button.dart';
import '/components/custom_textfield.dart';
import '/components/snackbar.dart';
import '/core/authentication_service.dart';
import '/core/firebase_exceptions.dart';
import '/screens/login.dart';
import '/screens/home_screen.dart';
import '/utils/loader.dart';
import '/utils/validator.dart';
import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget{
  static const String id = 'create_post';
  const CreatePost({Key? key}) : super(key:key);

  @override
  State<CreatePost> createState() => _CreatePost();

}

class _CreatePost extends State<CreatePost>{
  final _key = GlobalKey<FormState>();

  @override
  void dispose(){
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
                  const Align(
                    child: Text(
                      'New',
                      style: TextStyle(
                        fontFamily: 'Cherry',
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    child: Text(
                      'Post',
                      style: TextStyle(
                        fontFamily: 'Cherry',
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}