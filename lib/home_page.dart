import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taska/home_page_components/appbar_titles.dart';
import 'package:taska/home_page_components/bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Container(
                  height: screenHeight * 0.18,
                  padding: const EdgeInsets.all(16),
                  child: const BottomSheetComponents(),
                ),
              ),
            ),
          );
        },
        backgroundColor: const Color(0xff55949b),
        child: const Icon(Icons.add, color: Colors.white),
      ),
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
