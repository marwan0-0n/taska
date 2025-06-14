// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taska/widgets/cust_buttom.dart';
import 'package:taska/widgets/logo.dart';
import 'package:taska/widgets/text_form_field.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController password2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil("Auth Page", (route) => false);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        iconTheme: const IconThemeData(size: 35, color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Center(child: CircleLogo()),
                Text(
                  "Let's Sign You Up",
                  style: TextStyle(
                    fontSize: screenWidth * 0.1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Welcome To Taska!",
                  style: TextStyle(
                    fontSize: screenWidth * 0.09,
                    color: const Color(0xffB0B0B0),
                  ),
                ),
                Form(
                  key: formState,
                  child: Column(
                    children: [
                      CustReqTextForm(
                        titleText: "Username",
                        hint: "Enter Username",
                        textConroller: userName,
                      ),
                      Container(height: screenHeight / 50),
                      CustReqTextForm(
                        titleText: "Email",
                        hint: "Enter Email",
                        textConroller: email,
                      ),
                      Container(height: screenHeight / 50),
                      PasswordForm(passwordController: password),
                      Container(height: screenHeight / 50),
                      ConfirmPasswordForm(
                        confirmPasswordController: password2,
                        originalPasswordController: password,
                      ),
                      Container(height: screenHeight / 50),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xffB0B0B0),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("Login");
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                CustButtom(
                  colorCode: 0xffb2f0d4,
                  text: "Sign Up",
                  onPressed: () async {
                    if (formState.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                              email: email.text,
                              password: password.text,
                            );
                        await FirebaseAuth.instance.currentUser!
                            .sendEmailVerification();
                        Navigator.of(context).pushNamed("Verify page");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: 'Weak Password',
                            desc: 'The password provided is too weak.',
                          ).show();
                        } else if (e.code == 'email-already-in-use') {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: 'Account already exists',
                            desc: 'The account already exists for that email.',
                          ).show();
                        } else {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: 'Wrong Email',
                            desc: 'The email entered is wrong try again',
                          ).show();
                        }
                      }
                    }
                  },
                  textColorCode: 0xff000000,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
