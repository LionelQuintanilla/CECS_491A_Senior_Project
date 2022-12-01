import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

String userName = "";
String userID = "";
String userEmail = "";
String socialMediaID = "";
String socialMediaEmail = "";
String socialMediaAppName = "";

String twitterID = "";
bool hasTwitter = false;

String instagramID = "";
bool hasInstagram = false;

String facebookID = "";
bool hasFacebook = false;

String snapchatID = "";
bool hasSnapchat = false;

Future<String> getUser() async {
  Uri getUserURL = Uri.parse('https://www.darkriderindustries.com/getUser.php?useremail=$userEmail');
  var response = await http.get(getUserURL);
  var jsonResponse = convert.jsonDecode(response.body);
  return jsonResponse[0]['UserID'];
}

getSocials() async {
  Uri getSocialsURL = Uri.parse('https://www.darkriderindustries.com/getSocials.php?userid=$userID');
  var response = await http.get(getSocialsURL);
  var jsonResponse = convert.jsonDecode(response.body);

  for (int i = 0; i < jsonResponse.length; i++) {
    String currApp = jsonResponse[i]['SocialMediaAppName'];
    String currAppID = jsonResponse[i]['SocialMediaID'];

    print("Current App: " + currApp);

    if (currApp == 'twitter') {
      hasTwitter = true;
      twitterID = currAppID;
    }
    else if (currApp == 'facebook') {
      hasFacebook = true;
      facebookID = currAppID;
    }
    else if (currApp == 'instagram') {
      hasInstagram = true;
      instagramID = currAppID;
    }
  }

  //print("hasTwitter: " + hasTwitter.toString());
  //print("hasFacebook: " + hasFacebook.toString());
  //print("hasInstagram: " + hasInstagram.toString());
  //print("hasSnapchat: " + hasSnapchat.toString());

}

insertNewUser() async {
  Uri insertNewUserURL = Uri.parse('https://www.darkriderindustries.com/insertNewUser.php?useremail=$userEmail&username=$userName');
  var response = await http.post(insertNewUserURL);
}

insertNewSocial() async {
  Uri insertNewUserURL = Uri.parse('https://www.darkriderindustries.com/insertNewSocial.php?userid=$userID&useremail=$userEmail&appname=$socialMediaAppName');
  var response = await http.post(insertNewUserURL);
}

deleteUserSocial() async {
  Uri deleteSocialURL = Uri.parse('https://www.darkriderindustries.com/deleteUserSocial.php?socialid=$socialMediaID');
  var response = await http.post(deleteSocialURL);
}