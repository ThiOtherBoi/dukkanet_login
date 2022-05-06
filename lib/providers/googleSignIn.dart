import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLogin extends ChangeNotifier {
  final GoogleSignIn googleSignInUser = new GoogleSignIn(); //Instance
  GoogleSignInAccount? _user; //Storing signed in account

  GoogleSignInAccount get user =>
      _user!; //Getter for user details like email/name

  Future googleLogin() async {
    final gUser = await googleSignInUser.signIn();
    if (gUser == null) {
      return;
    } else
      _user = gUser; //If no user was signed in return, else save data in _user.

    final auth = await gUser.authentication;

    final UserCredentials = GoogleAuthProvider.credential(
        accessToken: auth.accessToken,
        idToken: auth.idToken); //get credentials for firebase.

    await FirebaseAuth.instance.signInWithCredential(
        UserCredentials); //Authenticate user in firebase auth.
  }

  Future logout() async {
    await googleSignInUser.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
