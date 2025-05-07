// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application/core/constant/app_color.dart';
import '../../../../config/app/controller/appcontroller.dart';
import '../../../../core/constant/app_string.dart';
import '../../../../core/components/appbar.dart';
import '../../../../core/components/button.dart';
import '../../../../core/components/image_view.dart';
import '../../../../core/components/textfield.dart';
import '../../../home/view/view.dart';
import '../controller/add_note_controller.dart';
import '../controller/add_note_states.dart';
import 'widgets/chosse_color.dart';

class AddingNoteScreen extends StatelessWidget {
  final String type;
  final Map? note;
  final List<String> imgList;
  const AddingNoteScreen(
      {Key? key, this.note, required this.type, required this.imgList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddingNoteController()
        ..initialValues(imgList, type)
        ..getNoteIdToUpdate(type, note!),
      child: BlocBuilder<AppController, AppStates>(
        builder: (context, state) {
          final appController = AppController.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: appbar(
                isArabic: context.locale.toString() == AppString.arabic,
                head: AppString.addNote.tr(),
                context: context,
                changeTheme: false),
            body: BlocBuilder<AddingNoteController, AddingTaskStates>(
              builder: (context, state) {
                final controller = AddingNoteController.get(context);

                return SafeArea(
                  top: false,
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            // ignore: prefer_const_constructors
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // TextFieldItem(
                                //     onChange: (val) {
                                //       if (val.isNotEmpty) {
                                //         controller.detectLan(val, "title");
                                //       } else {
                                //         controller.titleLan = "en";
                                //       }
                                //       controller.emit(LanguageState());
                                //     },
                                //     valid: AppString.validateMsg.tr(),
                                //     controller: controller.titleController,
                                //     lan: controller.titleLan,
                                //     lable: AppString.title.tr()),
                                // Divider(
                                //   color: Theme.of(context).brightness.index == 0
                                //       ? Colors.grey.shade300
                                //       : Colors.black,
                                //   thickness: .8,
                                //   height: 0,
                                // ),
                                TextFieldItem(
                                  onChange: (val) {
                                    if (val.isNotEmpty) {
                                      controller.detectLan(val, "note");
                                    } else {
                                      controller.noteLan = "en";
                                    }
                                    controller.emit(LanguageState());
                                  },
                                  valid: AppString.validateMsg.tr(),
                                  lan: controller.noteLan,
                                  controller: controller.noteController,
                                  lable: AppString.writeHere.tr(),
                                  lines: MediaQuery.of(context).size.height.ceil(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        controller.imgsConverted.isEmpty
                            ? const SizedBox.shrink()
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  AppString.images.tr(),
                                  style: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w700),
                                ),
                              ),
                        controller.imgsConverted.isEmpty
                            ? const SizedBox()
                            : SingleChildScrollView(
                                padding: const EdgeInsets.only(right: 10),
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    children: List.generate(
                                  controller.imgsConverted.length,
                                  (index) => ImageViewShape(
                                    onDelete: () {
                                      controller.deleteImage(index);
                                    },
                                    img: controller.imgsConverted[index],
                                    isImg: true,
                                  ),
                                ))),
                        const ChosseColor(),
                        Row(
                          children: [
                            Expanded(
                              child: ButtonItem(
                                
                                head: controller.id.isEmpty
                                    ? AppString.add.tr()
                                    : AppString.update.tr(),
                                onTap: () {
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    controller.textFieldLan("title");
                                    controller.textFieldLan("note");
                                    if (controller.id.isEmpty) {
                                      appController.insertNote(
                                          titleType: controller.noteContain
                                              ? "ar"
                                              : "en",
                                          noteType: controller.noteContain
                                              ? "ar"
                                              : "en",
                                          titleController: controller
                                                      .noteController
                                                      .text
                                                      .length >
                                                  10
                                              ? controller.noteController.text
                                                      .trim()
                                                      .contains(" ")
                                                  ? controller
                                                      .noteController.text
                                                      .split(" ")[0]
                                                  : controller
                                                      .noteController.text
                                              : controller.noteController.text
                                                  .trim(),
                                          noteController: controller
                                                  .noteController.text.isEmpty
                                              ? ""
                                              : controller.noteController.text
                                                  .trim(),
                                          pickerBGColor:
                                              controller.pickerBGColor,
                                          pickerTextColor:
                                              controller.pickerTextColor,
                                          imgs: controller.imgData);
                                    } else {
                                      appController.updateNote(
                                          titleType: controller.noteContain
                                              ? "ar"
                                              : "en",
                                          noteType: controller.noteContain
                                              ? "ar"
                                              : "en",
                                          titleController: controller
                                                      .noteController
                                                      .text
                                                      .length >
                                                  10
                                              ? controller.noteController.text
                                                      .trim()
                                                      .contains(" ")
                                                  ? controller
                                                      .noteController.text
                                                      .split(" ")[0]
                                                  : controller
                                                      .noteController.text
                                              : controller.noteController.text
                                                  .trim(),
                                          noteController: controller
                                                  .noteController.text.isEmpty
                                              ? ""
                                              : controller.noteController.text
                                                  .trim(),
                                          pickerBGColor:
                                              controller.pickerBGColor,
                                          pickerTextColor:
                                              controller.pickerTextColor,
                                          id: controller.id,
                                          imgs: controller.imgData);
                                    }
                                    controller.noteContain = false;
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MainScreen()),
                                        (route) => false);
                                  }
                                },
                              ),
                            ),
                            FloatingActionButton(
                                backgroundColor: AppColor.mainColor2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                onPressed: () async {
                                  await controller.getImage();
                                },
                                child: const Icon(
                                  CupertinoIcons.photo_fill_on_rectangle_fill,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ],
                    ),
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
