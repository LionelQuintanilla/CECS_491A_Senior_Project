import 'package:firebase_auth/firebase_auth.dart';
import '/core/firebase_exceptions.dart';
import 'dart:async';
import '/utils/db_resources.dart';

class AuthenticationService {

  // Opens a connection to Firebase authentication service
  static final auth = FirebaseAuth.instance;
  // The status of the current sessions's authentication
  static late AuthStatus _status;

  // Logs in a user using Firebase
  Future<AuthStatus> login({
    // Takes the user's email and password as parameters
    required String email,
    required String password,
  }) async {
    try {
      // Passes the user's email and password to Firebase
      await auth.signInWithEmailAndPassword(email: email, password: password);
      /* If the login is successful, the user is signed in and the authentication
      status is set to true */
      _status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      // If an error occurs, an error message is returned
      _status = AuthExceptionHandler.handleAuthException(e);
    }
    // Returns the current authentication status
    return _status;
  }

  // Creates a new user account in Firebase
  Future<AuthStatus> createAccount({
    // Takes the user's email, username, and a password as parameters
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      /* Passes the user's email and password to Firebase to create a new account */
      UserCredential newUser = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      /* At this point, the new user account should have been created. The user
      is logged in with this account. Sets the username of the new user */
      auth.currentUser!.updateDisplayName(name);
      //_auth.currentUser!.updateProfile(displayName: username);

      /* Sends a verification email to the new user's email */
      newUser.user!.sendEmailVerification();

      // Sets the authentication status of the new user to true
      _status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      // If an error occurs, returns an error message
      _status = AuthExceptionHandler.handleAuthException(e);
    }

    // Saves the username and email of the new user for the posting API
    userEmail = email;
    userName = name;

    // Inserts the new user into the user profile DB
    insertNewUser();

    // Returns the authetication status of the new user
    return _status;
  }

  Future<AuthStatus> resetPassword({required String email}) async {
    await auth
        .sendPasswordResetEmail(email: email)
        .then((value) => _status = AuthStatus.successful)
        .catchError(
            (e) => _status = AuthExceptionHandler.handleAuthException(e));

    return _status;
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }

}