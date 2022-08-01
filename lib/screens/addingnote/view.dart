import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remember/screens/addingnote/states.dart';

import '../../components/appbar.dart';
import '../../components/button.dart';
import '../../components/textfield.dart';
import '../../cubit/appcontroller.dart';
import '../../cubit/appstate.dart';
import 'controller.dart';

class AddingNoteScreen extends StatelessWidget {
  final String type;
  final Map? note;
  const AddingNoteScreen({Key? key, this.note, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AddingNoteController()
        ..initialValues()
        ..getNoteIdToUpdate(type, note!),
      child: BlocBuilder<AppController, AppStates>(
        builder: (context, state) {
          final appController = AppController.get(context);
          return Scaffold(
            appBar: appbar(size: size, head: "Add Note", context: context,changeTheme:false),
            body: BlocBuilder<AddingNoteController, AddingTaskStates>(
              builder: (context, state) {
                final controller = AddingNoteController.get(context);

                return Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.shortestSide * .03,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFieldItem(
                                  onChange: (val) {
                                    if (val.isNotEmpty) {
                                      controller.detectLan(val, "title");
                                    } else {
                                      controller.titleLan = "en";
                                    }
                                    controller.emit(LanguageState());
                                  },
                                  valid: "This field must not be empty",
                                  controller: controller.titleController,
                                  lan: controller.titleLan,
                                  lable: "Title"),
                              const Divider(
                                color: Colors.black,
                                thickness: .8,
                              ),
                              TextFieldItem(
                                onChange: (val) {
                                  if (val.isNotEmpty) {
                                    controller.detectLan(val, "note");
                                  } else {
                                    controller.noteLan = "en";
                                  }
                                    controller.emit(LanguageState());

                                },
                                lan: controller.noteLan,
                                controller: controller.noteController,
                                lable: " Write here...",
                                lines: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.shortestSide * .03),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.showColorPicker(context, false);
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: controller.pickerBGColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "BG color",
                                    style: TextStyle(
                                        fontSize: size.shortestSide * .05,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                controller.showColorPicker(context, true);
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: controller.pickerTextColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Text color",
                                    style: TextStyle(
                                        fontSize: size.shortestSide * .05,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      ButtonItem(
                        textSize: .08,
                        head: controller.id.isEmpty ? "Add" : "Update",
                        onTap: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.textFieldLan("title");
                            controller.textFieldLan("note");
                            if (controller.id.isEmpty) {
                              appController.insertNote(
                                  controller.titleContain ? "ar" : "en",
                                  controller.noteContain ? "ar" : "en",
                                  controller.titleController,
                                  controller.noteController,
                                  controller.pickerBGColor,
                                  controller.pickerTextColor);
                            } else {
                              appController.updateNote(
                                  controller.titleContain ? "ar" : "en",
                                  controller.noteContain ? "ar" : "en",
                                  controller.titleController,
                                  controller.noteController,
                                  controller.pickerBGColor,
                                  controller.pickerTextColor,
                                  controller.id);
                            }
                            controller.titleContain = false;
                            controller.noteContain = false;
                            Navigator.pop(context);
                          }
                        },
                        size: size,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
