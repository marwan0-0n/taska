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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const Center(child: CircleLogo()),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: const Text(
                "Let's Sign You Up",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 35),
              child: const Text(
                "Welcome To Taska!",
                style: TextStyle(fontSize: 37, color: Color(0xffB0B0B0)),
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
                  Container(height: 25),
                  CustReqTextForm(
                    titleText: "Email",
                    hint: "Enter Email",
                    textConroller: email,
                  ),
                  Container(height: 25),
                  PasswordForm(passwordController: password),
                  Container(height: 25),
                  ConfirmPasswordForm(
                    confirmPasswordController: password2,
                    originalPasswordController: password,
                  ),
                  Container(height: 25),
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
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
    );
  }
}
