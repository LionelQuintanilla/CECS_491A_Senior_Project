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


class SelectAccounts extends StatefulWidget{
  static const String id = 'select_accounts';
  const SelectAccounts({Key? key}) : super(key:key);

  @override
  State<SelectAccounts> createState() => _SelectAccounts();

}
class _SelectAccounts extends State<SelectAccounts> {

  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return const Scaffold(
    );
  }
}