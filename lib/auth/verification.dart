// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taska/widgets/cust_buttom.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  String notVerifyed = "";
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    height: 300,
                    margin: EdgeInsets.symmetric(vertical: screenHeight / 100),
                    child: Image.asset(
                      "assets/images/account_verification.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Verify your account",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Center(
                      child: Text(
                        "We've sent you a verification link to your Email",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xffB0B0B0),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(height: 30),
                  Text(
                    notVerifyed,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustButtom(
                    colorCode: 0xff55949b,
                    text: "Login",
                    onPressed: () async {
                      await FirebaseAuth.instance.currentUser?.reload();
                      User? user = FirebaseAuth.instance.currentUser;
                      if (user != null && user.emailVerified) {
                        Navigator.of(
                          context,
                        ).pushNamedAndRemoveUntil("Home", (route) => false);
                      } else {
                        setState(() {
                          notVerifyed = "Your email is not verified yet!";
                        });
                      }
                    },
                    textColorCode: 0xffFFFFFF,
                  ),
                  Container(height: 10),
                  InkWell(
                    onTap: () async {
                      await FirebaseAuth.instance.currentUser!
                          .sendEmailVerification();
                    },
                    child: const Text(
                      "Click here if you didn't recieve the email",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
