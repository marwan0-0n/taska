import 'package:flutter/material.dart';
import 'package:taska/widgets/cust_buttom.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: screenHeight / 3,
              width: screenWidth / 1.1,
              margin: EdgeInsets.symmetric(vertical: screenHeight / 25),
              child: Image.asset(
                "assets/images/Taskimage.png",
                fit: BoxFit.fill,
              ),
            ),
            const Center(
              child: Text(
                "Welcome to Taska",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: screenHeight / 100),
              child: const Center(
                child: Text(
                  "Where productivity meets peace of mind.\n Sign in and start achieving!",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xffB0B0B0),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(height: screenHeight / 35),
            CustButtom(
              colorCode: 0xff55949b,
              text: "Login",
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("Login");
              },
              textColorCode: 0xffFFFFFF,
            ),
            Container(height: screenHeight / 38),
            CustButtom(
              colorCode: 0xffb2f0d4,
              text: "Register",
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("Register");
              },
              textColorCode: 0xff000000,
            ),
          ],
        ),
      ),
    );
  }
}
