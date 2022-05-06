import './profileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './authentication.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      //Build Widget based on latest snapshot recieved
      stream: FirebaseAuth.instance
          .authStateChanges(), // Notifies about changes to the user's sign-in state (such as sign-in or sign-out).
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return SnackBar(
            content: Text("Could Not Sign in"),
          );
        } else if (snapshot.hasData) {
          return ProfileScreen();
        } else
          return Authentication();
      },
    );
  }
}
