// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taska/widgets/cust_buttom.dart';
import 'package:taska/widgets/divider.dart';
import 'package:taska/widgets/loading.dart';
import 'package:taska/widgets/logo.dart';
import 'package:taska/widgets/other_signin_options.dart';
import 'package:taska/widgets/text_form_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

GlobalKey<FormState> formState = GlobalKey();
bool passShowStat = true;
bool isLoading = false;

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

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
        toolbarHeight: 45,
        iconTheme: const IconThemeData(size: 35, color: Colors.black),
      ),
      body: isLoading
          ? const LoadingSpinKit()
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Center(child: CircleLogo()),
                      Text(
                        "Let's Sign You In",
                        style: TextStyle(
                          fontSize: screenWidth * 0.1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: screenHeight / 18),
                        child: Text(
                          "Welcome Back!",
                          style: TextStyle(
                            fontSize: screenWidth * 0.09,
                            color: const Color(0xffB0B0B0),
                          ),
                        ),
                      ),
                      Form(
                        key: formState,
                        child: Column(
                          children: [
                            CustReqTextForm(
                              titleText: "Email",
                              hint: "Enter your email",
                              textConroller: email,
                            ),
                            SizedBox(height: screenHeight / 50),
                            PasswordForm(passwordController: password),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          0,
                          screenHeight / 150,
                          0,
                          screenHeight / 25,
                        ),
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            if (email.text == "") {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Email field is empty',
                                desc:
                                    'Please enter your email in the email field.',
                              ).show();
                            } else {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.question,
                                animType: AnimType.rightSlide,
                                title: 'Password reset',
                                desc: 'Want to receive password reset mail?',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () async {
                                  await FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                        email: email.text,
                                      );
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    animType: AnimType.rightSlide,
                                    title: 'Password reset mail sent',
                                    desc:
                                        'Check your inbox and reset password.',
                                  ).show();
                                },
                              ).show();
                            }
                          },
                          child: const Text(
                            "Forget Password?",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const CustDivider(),
                      SizedBox(height: screenHeight / 40),
                      const OtherSigninOptions(),
                      SizedBox(height: screenHeight / 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB0B0B0),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                "Register",
                                (route) => false,
                              );
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      CustButtom(
                        colorCode: 0xff55949b,
                        text: "Login",
                        onPressed: () async {
                          if (formState.currentState!.validate()) {
                            try {
                              isLoading = true;
                              setState(() {});
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                    email: email.text,
                                    password: password.text,
                                  );
                              Navigator.of(
                                context,
                              ).pushReplacementNamed("Home");
                              isLoading = false;
                              setState(() {});
                            } on FirebaseAuthException catch (e) {
                              isLoading = false;
                              setState(() {});
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Authentication Error',
                                desc:
                                    e.message ??
                                    'An unknown authentication error occurred.',
                              ).show();
                            }
                          }
                        },
                        textColorCode: 0xffFFFFFF,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
