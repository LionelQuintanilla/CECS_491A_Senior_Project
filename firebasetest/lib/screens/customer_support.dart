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

class CustomerSupport extends StatefulWidget{
  static const String id = 'support_screen';
  const CustomerSupport({Key? key}) : super(key:key);

  @override
  State<CustomerSupport> createState() => _CustomerSupport();

}

class _CustomerSupport extends State<CustomerSupport>{
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

  }
}