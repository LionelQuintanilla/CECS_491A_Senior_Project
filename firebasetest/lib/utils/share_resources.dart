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

/* Text editing controllers that capture input from the post detail form fields.
They have been placed in this file so that they can be accessed from pages
outside of the post details page */
final descriptionController = TextEditingController();
final hashtagController = TextEditingController();
final taggedPeopleController = TextEditingController();

/* Variables that keep track of the text of the post */
String description = "";
String hashtags = "";
String tags = "";

// Tracks the status of a post
String? twitterPostStatus = "";
String? facebookPostStatus = "";
String? instagramPostStatus = "";

// File path of the post image
var postImagePath;

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