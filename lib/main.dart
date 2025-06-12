import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:taska/auth/auth.dart';
import 'package:taska/auth/login.dart';
import 'package:taska/auth/register.dart';
import 'package:taska/auth/verification.dart';
import 'package:taska/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //     if (user == null) {
  //       print('User is currently signed out!');
  //     } else {
  //       print('User is signed in!');
  //     }
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirebaseAuth.instance.currentUser == null
          ? const AuthPage()
          : const HomePage(),
      routes: {
        "Login": (context) => const Login(),
        "Register": (context) => const Register(),
        "Auth Page": (context) => const AuthPage(),
        "Home": (context) => const HomePage(),
        "Verify page": (context) => const Verification(),
      },
      theme: ThemeData(fontFamily: "Nunito"),
    );
  }
}
