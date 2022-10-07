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
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;
    return Scaffold(

    );
  }
}