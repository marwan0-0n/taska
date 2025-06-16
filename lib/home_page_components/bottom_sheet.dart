import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taska/widgets/loading.dart';

class BottomSheetComponents extends StatefulWidget {
  final Function refreshTasks;

  const BottomSheetComponents({super.key, required this.refreshTasks});

  @override
  State<BottomSheetComponents> createState() => _BottomSheetComponentsState();
}

bool isLoading = false;

class _BottomSheetComponentsState extends State<BottomSheetComponents> {
  bool isTextNotEmpty = false;
  late TextEditingController name;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  CollectionReference tasks = FirebaseFirestore.instance.collection("tasks");
  addTask() async {
    await tasks.add({
      "name": name.text,
      "id": FirebaseAuth.instance.currentUser!.uid,
      "isChecked": false,
    });
  }

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
  }

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return isLoading
        ? const LoadingSpinKit()
        : Column(
            children: [
              Form(
                key: formState,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      isTextNotEmpty = value.trim().isNotEmpty;
                    });
                  },
                  autofocus: true,
                  controller: name,
                  decoration: const InputDecoration(
                    hint: Text(
                      "New Task",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.017),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  isTextNotEmpty == true
                      ? InkWell(
                          onTap: () {
                            try {
                              isLoading = true;
                              setState(() {});
                              addTask();
                              Navigator.of(context).pop();
                              widget.refreshTasks();
                              isLoading = false;
                            } catch (e) {
                              isLoading = false;
                              setState(() {});
                              AwesomeDialog(
                                // ignore: use_build_context_synchronously
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Error',
                                desc: '$e',
                              ).show();
                            }
                          },
                          child: Text(
                            "Save",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Text(
                          "Save",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ],
              ),
            ],
          );
  }
}
