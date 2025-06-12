import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taska/home_page_components/appbar_titles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(size: 32),
        title: const AppbarTitles(),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  googleSignIn.disconnect();
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil("Login", (route) => false);
                  await FirebaseAuth.instance.signOut();
                },
                child: const Text("Sign-out"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
