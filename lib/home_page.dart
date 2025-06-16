import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taska/home_page_components/appbar_titles.dart';
import 'package:taska/home_page_components/add_bottom_sheet.dart';
import 'package:taska/home_page_components/update_bottom_sheet.dart';
import 'package:taska/widgets/loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

bool isLoading = true;

class _HomePageState extends State<HomePage> {
  List<DocumentSnapshot> tasks = [];
  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("tasks")
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    tasks = querySnapshot.docs;
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
                  child: BottomSheetComponents(refreshTasks: getData),
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
                    child: tasks.isEmpty
                        ? Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(screenWidth * 0.05),
                                margin: EdgeInsets.only(
                                  bottom: screenWidth * 0.05,
                                ),
                                width: screenWidth,
                                height: screenHeight * 0.4,
                                child: Image.asset(
                                  "assets/images/empty_list.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                "No tasks?\nLet's change that!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.075,
                                ),
                              ),
                            ],
                          )
                        : ListView.builder(
                            physics: const ScrollPhysics(
                              parent: NeverScrollableScrollPhysics(),
                            ),
                            shrinkWrap: true,
                            itemCount: tasks.length,
                            itemBuilder: (context, i) =>
                                AnimationConfiguration.staggeredList(
                                  position: i,
                                  duration: const Duration(milliseconds: 375),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: ListTile(
                                        title: AnimatedDefaultTextStyle(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.045,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                tasks[i]['isChecked'] == true
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                          ),
                                          child: Text(
                                            tasks[i]['name'],
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        trailing: PopupMenuButton(
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  shape: const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                          top: Radius.circular(
                                                            20,
                                                          ),
                                                        ),
                                                  ),
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  builder: (context) => Padding(
                                                    padding: EdgeInsets.only(
                                                      bottom: MediaQuery.of(
                                                        context,
                                                      ).viewInsets.bottom,
                                                    ),
                                                    child: SingleChildScrollView(
                                                      child: Container(
                                                        height:
                                                            screenHeight * 0.18,
                                                        padding:
                                                            const EdgeInsets.all(
                                                              16,
                                                            ),
                                                        child: UpdateBottomSheet(
                                                          refreshTasks: getData,
                                                          oldName:
                                                              tasks[i]['name'],
                                                          taskID: tasks[i].id,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Text("Edit task"),
                                            ),
                                            PopupMenuItem(
                                              onTap: () async {
                                                await FirebaseFirestore.instance
                                                    .collection("tasks")
                                                    .doc(tasks[i].id)
                                                    .delete();
                                                setState(() {
                                                  tasks.removeAt(i);
                                                });
                                              },
                                              child: const Text("Delete task"),
                                            ),
                                          ],
                                        ),
                                        leading: Checkbox(
                                          value: tasks[i]['isChecked'] ?? false,
                                          onChanged: (value) async {
                                            final taskId = tasks[i].id;
                                            await FirebaseFirestore.instance
                                                .collection("tasks")
                                                .doc(taskId)
                                                .update({"isChecked": value});
                                            await getData();
                                          },
                                        ),
                                      ),
                                    ),
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
