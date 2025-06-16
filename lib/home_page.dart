import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taska/home_page_components/appbar_titles.dart';
import 'package:taska/home_page_components/bottom_sheet.dart';
import 'package:taska/widgets/loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

bool isLoading = true;

class _HomePageState extends State<HomePage> {
  List<bool> boxStatus = [];
  List tasks = [];
  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("tasks")
        .get();
    tasks.addAll(querySnapshot.docs);
    boxStatus = List.generate(tasks.length, (_) => false);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

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
        backgroundColor: const Color(0xffb2f0d4),
        child: const Icon(Icons.add, color: Colors.black),
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
      body: isLoading
          ? const LoadingSpinKit()
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color(0xff55949b),
                    ),
                    child: ListView.builder(
                      physics: const ScrollPhysics(
                        parent: NeverScrollableScrollPhysics(),
                      ),
                      shrinkWrap: true,
                      itemCount: tasks.length,
                      itemBuilder: (context, i) => ListTile(
                        title: Text(
                          tasks[i]['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        leading: Checkbox(
                          value: boxStatus[i],
                          onChanged: (value) {
                            setState(() {
                              boxStatus[i] = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
