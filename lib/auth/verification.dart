// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taska/widgets/cust_buttom.dart';
import 'package:taska/widgets/loading.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

bool isLoading = false;

class _VerificationState extends State<Verification> {
  String notVerifyed = "";
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil("Login", (route) => false);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        iconTheme: const IconThemeData(size: 35, color: Colors.black),
      ),
      body: isLoading
          ? const LoadingSpinKit()
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        height: 300,
                        margin: EdgeInsets.symmetric(
                          vertical: screenHeight / 100,
                        ),
                        child: Image.asset(
                          "assets/images/account_verification.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Center(
                        child: Text(
                          "Verify your account",
                          style: TextStyle(
                            fontSize: screenWidth * 0.13,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Center(
                          child: Text(
                            "We've sent you a verification link to your Email",
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color: const Color(0xffB0B0B0),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight / 30),
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
                          isLoading = true;
                          setState(() {});
                          await FirebaseAuth.instance.currentUser?.reload();
                          User? user = FirebaseAuth.instance.currentUser;
                          if (user != null && user.emailVerified) {
                            isLoading = false;
                            setState(() {});
                            Navigator.of(
                              context,
                            ).pushNamedAndRemoveUntil("Home", (route) => false);
                          } else {
                            isLoading = false;
                            setState(() {
                              notVerifyed = "Your email is not verified yet!";
                            });
                          }
                        },
                        textColorCode: 0xffFFFFFF,
                      ),
                      SizedBox(height: screenHeight / 90),
                      InkWell(
                        onTap: () async {
                          await FirebaseAuth.instance.currentUser!
                              .sendEmailVerification();
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.rightSlide,
                            title: 'Verfication email sent to your inbox',
                          ).show();
                        },
                        child: const Text(
                          "Click here if you didn't recieve the email",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
