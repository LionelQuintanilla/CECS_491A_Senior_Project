import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

/* Keeps track of the attributes regarding the user's profile and linked social
media profiles. Corresponds to the SQL schemas for the user profile and social
media RDBs, respectively. */
String userName = "";
String userID = "";
String userEmail = "";
String socialMediaID = "";
String socialMediaEmail = "";
String socialMediaAppName = "";

// Tracks if the user has a Twitter account linked to their profile
String twitterID = "";
bool hasTwitter = false;

// Tracks if the user has a Instagram account linked to their profile
String instagramID = "";
bool hasInstagram = false;

// Tracks if the user has a Facebook account linked to their profile
String facebookID = "";
bool hasFacebook = false;

// Tracks if the user has a Snapchat account linked to their profile
String snapchatID = "";
bool hasSnapchat = false;

// Queries the User Profiles DB to get the user's profile ID
Future<String> getUser() async {
  /* Fetches the user's data via a PHP script. The user's email is passed as
  parameter. The user's email is then used in the SQL statement. Since only
  one account is allowed per email, using the email as a query parameter should
  return only the user's account. */
  Uri getUserURL = Uri.parse('https://www.darkriderindustries.com/getUser.php?useremail=$userEmail');
  /* The PHP script returns the result of the SQL query as a JSON file. The JSON
  file is fetched when the query is finished executing. */
  var response = await http.get(getUserURL);
  // The JSON file is converted into a array so it can be operated on.
  var jsonResponse = convert.jsonDecode(response.body);
  // Returns the user's profile ID
  return jsonResponse[0]['UserID'];
}

// Queries the social media DB to get the accounts linked to the user's profile
getSocials() async {
  print("GOING BACK TO CALI");
  /* Fetches the user's data via a PHP script. The user's profile ID is passed
  as the parameter. The user's profile ID is then used in the SQL statement.
  Since user profile IDs are unique and social media accounts are linked to users
  via their profile ID, using the ID as a query parameter should return only the
  account linked to the user's profile. */
  Uri getSocialsURL = Uri.parse('https://www.darkriderindustries.com/getSocials.php?userid=$userID');
  /* The PHP script returns the result of the SQL query as a JSON file. The JSON
  file is fetched when the query is finished executing. */
  var response = await http.get(getSocialsURL);
  // The JSON file is converted into a array so it can be operated on.
  var jsonResponse = convert.jsonDecode(response.body);

  hasTwitter = false;
  hasInstagram = false;
  hasFacebook = false;
  hasSnapchat = false;

  /* Each social media profile returned is checked for which application it links.
  The status of each app is recorded for use in the sharing API */
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

/* Insert a new user into the user profiles SQL database. Passes the user's name
and email as parameters; the user ID is automatically generated */
insertNewUser() async {
  Uri insertNewUserURL = Uri.parse('https://www.darkriderindustries.com/insertNewUser.php?useremail=$userEmail&username=$userName');
  var response = await http.post(insertNewUserURL);
}

/* Insert a new social media account into the social media profiles database.
Passes the user's ID and email as parameters to link the social media account
to the user's profile, as well as the name of the app being linked. A unique
ID is generated for each user social media account. */
insertNewSocial() async {
  Uri insertNewUserURL = Uri.parse('https://www.darkriderindustries.com/insertNewSocial.php?userid=$userID&useremail=$userEmail&appname=$socialMediaAppName');
  var response = await http.post(insertNewUserURL);
}

/* Delete a social media account from a user's profile. Passes the ID of the social
media profile */
deleteUserSocial() async {
  Uri deleteSocialURL = Uri.parse('https://www.darkriderindustries.com/deleteUserSocial.php?socialid=$socialMediaID');
  var response = await http.post(deleteSocialURL);
}

deleteDuplicates() async {
  Uri deleteDuplicatesURL = Uri.parse('https://www.darkriderindustries.com/clearDuplicates.php?userid=$userID&appname=$socialMediaAppName');
  var response = await http.post(deleteDuplicatesURL);
}