// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class OtherSigninOptions extends StatefulWidget {
  const OtherSigninOptions({super.key});

  @override
  State<OtherSigninOptions> createState() => _OtherSigninOptionsState();
}

class _OtherSigninOptionsState extends State<OtherSigninOptions> {
  @override
  Widget build(BuildContext context) {
    Future signInWithGoogle() async {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.of(context).pushNamedAndRemoveUntil("Home", (route) => false);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            signInWithGoogle();
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: BoxBorder.all(color: const Color(0xff7dd2ed)),
            ),
            child: Image.asset("assets/images/Google.png"),
          ),
        ),
        // Container(width: 20),
        // InkWell(
        //   onTap: () {},
        //   child: Container(
        //     width: 50,
        //     height: 50,
        //     decoration: BoxDecoration(
        //       color: const Color(0xff0866FF),
        //       borderRadius: BorderRadius.circular(18),
        //       border: BoxBorder.all(color: const Color(0xff7dd2ed)),
        //     ),
        //     child: Image.asset("assets/images/Facebook.png"),
        //   ),
        // ),
      ],
    );
  }
}
