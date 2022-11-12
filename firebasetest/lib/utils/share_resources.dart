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
import '/screens/select_posted_accounts.dart';

String description = "";
String hashtags = "";
String tags = "";

void setDesc(String descInput) {
  description = descInput;
}

void setHashtags (String hashtagsInput) {
  hashtags = hashtagsInput;
}

void setTags (String tagsInput) {
  tags = tagsInput;
}

String getDesc() {
  return description;
}

String getHashtags() {
  return hashtags;
}

String getTags() {
  String formattedTags = "@" + tags;
  return formattedTags;
}