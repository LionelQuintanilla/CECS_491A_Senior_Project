import 'package:firebasetest/screens/create_post.dart';
import 'package:firebasetest/screens/customer_support.dart';
import 'package:firebasetest/screens/facebook_add.dart';
import 'package:firebasetest/screens/instagram_add.dart';
import 'package:firebasetest/screens/new_post_description.dart';
import 'package:firebasetest/screens/verification_screen.dart';
import 'package:firebasetest/screens/select_posted_accounts.dart';

import '/screens/home_screen.dart';
import '/screens/login.dart';
import '/screens/reset_password.dart';
import '/screens/sign_up.dart';
import '/screens/manage_accounts.dart';
import '/screens/twitter_add.dart';
import '/screens/snapchat_add.dart';
import 'package:flutter/material.dart';
import '/screens/select_accounts.dart';
import '/screens/twitter_add_2.dart';
import '/screens/instagram_add_2.dart';
import '/screens/facebook_add_2.dart';
import '/screens/add_accounts.dart';
import '/screens/remove_accounts.dart';
import '/screens/twitter_remove.dart';
import '/screens/facebook_remove.dart';
import '/screens/instagram_remove.dart';
import '/screens/finished_screen.dart';
import '/screens/app_settings.dart';
import '/screens/personal_information.dart';

class MyRouter {
  static get file => null;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      /* If the Navigator calls the ID of a page, the app renders the main class
      of that page (basically, opens the page) */
      case SelectAccounts.id:
        return MaterialPageRoute(builder: (_) => const SelectAccounts());
      case PostDescription.id:
        return MaterialPageRoute(builder: (_) =>    PostDescription(file: file,));
      case CreatePost.id:
        return MaterialPageRoute(builder: (_) => const CreatePost());
      case CustomerSupport.id:
        return MaterialPageRoute(builder: (_) => const CustomerSupport());
      case SignUpScreen.id:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case LoginScreen.id:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case PersonalInformation.id:
        return MaterialPageRoute(builder: (_) => const PersonalInformation());
      case ResetPasswordScreen.id:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());

      case HomeScreen.id:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case AppSettings.id:
        return MaterialPageRoute(builder: (_) => const AppSettings());

      case ManageAccounts.id:
        return MaterialPageRoute(builder: (_) => const ManageAccounts());

      case TwitterAdd.id:
        return MaterialPageRoute(builder: (_) => const TwitterAdd());

      case InstagramAdd.id:
        return MaterialPageRoute(builder: (_) => const InstagramAdd());

      case FacebookAdd.id:
        return MaterialPageRoute(builder: (_) => const FacebookAdd());

      case SnapchatAdd.id:
        return MaterialPageRoute(builder: (_) => const SnapchatAdd());

        /*
      case SelectPostedAccounts.id:
        return MaterialPageRoute(builder: (_) =>  const SelectPostedAccounts());*/

      case TwitterAdd2.id:
        return MaterialPageRoute(builder: (_) => const TwitterAdd2());

      case InstagramAdd2.id:
        return MaterialPageRoute(builder: (_) => const InstagramAdd2());

      case FacebookAdd2.id:
        return MaterialPageRoute(builder: (_) => const FacebookAdd2());

      case AddAccounts.id:
        return MaterialPageRoute(builder: (_) => const AddAccounts());

      case RemoveAccounts.id:
        return MaterialPageRoute(builder: (_) => const RemoveAccounts());

      case TwitterRemove.id:
        return MaterialPageRoute(builder: (_) => const TwitterRemove());

      case FacebookRemove.id:
        return MaterialPageRoute(builder: (_) => const FacebookRemove());

      case InstagramRemove.id:
        return MaterialPageRoute(builder: (_) => const InstagramRemove());

      case FinishedScreen.id:
        return MaterialPageRoute(builder: (_) => const FinishedScreen());

      case VerifyScreen.id:
        return MaterialPageRoute(builder: (_) => const VerifyScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('Something went wrong')),
            ));
    }
  }
}