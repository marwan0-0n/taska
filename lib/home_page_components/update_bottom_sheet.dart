import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taska/widgets/loading.dart';

class UpdateBottomSheet extends StatefulWidget {
  final Function refreshTasks;
  final String oldName;
  final String taskID;
  const UpdateBottomSheet({
    super.key,
    required this.refreshTasks,
    required this.oldName,
    required this.taskID,
  });

  @override
  State<UpdateBottomSheet> createState() => _UpdateBottomSheetState();
}

bool isLoading = false;

class _UpdateBottomSheetState extends State<UpdateBottomSheet> {
  bool isTextNotEmpty = false;
  late TextEditingController name;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  CollectionReference tasks = FirebaseFirestore.instance.collection("tasks");
  updateTask() async {
    await tasks.doc(widget.taskID).update({'name': name.text});
  }

  @override
  void initState() {
    name = TextEditingController();
    super.initState();
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
                  decoration: InputDecoration(
                    hint: Text(
                      widget.oldName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
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
                              updateTask();
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
