import 'package:clubhouse/screens/phone/phone_screen.dart';
import 'package:clubhouse/utils/router.dart';
import 'package:clubhouse/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return PhoneScreen();
        }
      },
    );
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }

  signIn(BuildContext context, AuthCredential authCreds) async {
    AuthResult result =
        await FirebaseAuth.instance.signInWithCredential(authCreds);

    if (result.user != null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Routers.home, (route) => false);
    } else {
      print("Error");
    }
  }

  signInWithOTP(BuildContext context, smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    signIn(context, authCreds);
  }
}
