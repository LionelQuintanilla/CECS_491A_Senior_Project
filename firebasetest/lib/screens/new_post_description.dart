import 'package:firebasetest/screens/verification_screen.dart';
import 'package:flutter/services.dart';
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
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '/screens/create_post.dart';
import '/screens/select_accounts.dart';


class PostDescription extends StatefulWidget{
  static const String id = 'post_description';
  const PostDescription({Key? key}) : super(key:key);

  @override
  State<PostDescription> createState() => _PostDescription();

}

class _PostDescription extends State<PostDescription>{

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
                      'New Post',
                      style: TextStyle(
                        fontFamily: 'Cherry',
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Align(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 200),
                        child: const Icon(
                          Icons.image,
                          size: 300,
                        ),
                      ),
                      alignment: Alignment.center
                  ),
                  const Align(
                    alignment: Alignment(-.9, -1),
                    child:
                        Text(
                          'Caption',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                  ),
                  TextFormField(
                    minLines: 1,
                    maxLines: 1,
                    maxLength: 150,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 5,
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.black, width: 5),
                      ),
                      hintText: 'Enter the caption for your post here',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      )
                    ),
                  ),
                  const Align(
                    alignment: Alignment(-.9, -1),
                    child:
                    Text(
                      'Hashtags',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TextFormField(
                    minLines: 1,
                    maxLines: 1,
                    maxLength: 100,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 5,
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.black, width: 5),
                        ),
                        hintText: 'Enter the tags for your post here',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        )
                    ),
                  ),
                  const Align(
                    alignment: Alignment(-.9, -1),
                    child:
                    Text(
                      'Tag Someone',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TextFormField(
                    minLines: 1,
                    maxLines: 1,
                    maxLength: 100,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 5,
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.black, width: 5),
                        ),
                        hintText: 'Enter the people included in your post here',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        )
                    ),
                  ),
                  Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: OutlinedButton(
                            onPressed: () => Navigator.pushNamed(context, SelectAccounts.id),
                            child: const Text('Next'),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}