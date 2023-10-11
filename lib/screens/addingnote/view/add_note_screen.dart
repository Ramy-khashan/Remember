// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import '../../../app_intitial/cubit/app_cubit/appcontroller.dart';
import '../../../app_intitial/cubit/app_cubit/appstate.dart';
import '../../../core/utils/app_string.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/image_view.dart';
import '../../../core/widgets/textfield.dart';
import '../../main_screen/view/view.dart';
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
    Size size = MediaQuery.of(context).size;
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
                size: size,
                head: AppString.addNote.tr(),
                context: context,
                changeTheme: false),
            body: BlocBuilder<AddingNoteController, AddingTaskStates>(
              builder: (context, state) {
                final controller = AddingNoteController.get(context);

                return Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                  valid: AppString.validateMsg.tr(),
                                  controller: controller.titleController,
                                  lan: controller.titleLan,
                                  lable: AppString.title.tr()),
                              Divider(
                                color: Theme.of(context).brightness.index == 0
                                    ? Colors.grey.shade300
                                    : Colors.black,
                                thickness: .8,
                                height: 0,
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
                                valid: AppString.validateMsg.tr(),
                                lan: controller.noteLan,
                                controller: controller.noteController,
                                lable: AppString.writeHere.tr(),
                                lines: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              AppString.images.tr(),
                              style: TextStyle(
                                  fontSize: size.shortestSide * .051,
                                  fontWeight: FontWeight.w700),
                            ),
                            const Spacer(),
                            controller.imgsConverted.isEmpty
                                ? const SizedBox.shrink()
                                : GestureDetector(
                                    onTap: () async {
                                      await controller.getImage();
                                    },
                                    child: Icon(
                                      Icons.add,
                                      size: size.shortestSide * .07,
                                    ))
                          ],
                        ),
                      ),
                      controller.imgsConverted.isEmpty
                          ? InkWell(
                              borderRadius: BorderRadius.circular(13),
                              onTap: () async {
                                await controller.getImage();
                              },
                              child: ImageViewShape(
                                size: size,
                                img: "",
                                isImg: false,
                              ),
                            )
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
                                  size: size,
                                  img: controller.imgsConverted[index],
                                  isImg: true,
                                ),
                              ))),
                      ChosseColor(size: size),
                      ButtonItem(
                        textSize: .08,
                        head: controller.id.isEmpty
                            ? AppString.add.tr()
                            : AppString.update.tr(),
                        onTap: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.textFieldLan("title");
                            controller.textFieldLan("note");
                            if (controller.id.isEmpty) {
                              appController.insertNote(
                                  titleType:
                                      controller.titleContain ? "ar" : "en",
                                  noteType:
                                      controller.noteContain ? "ar" : "en",
                                  titleController: controller.titleController,
                                  noteController:
                                      controller.noteController.text.isEmpty
                                          ? ""
                                          : controller.noteController,
                                  pickerBGColor: controller.pickerBGColor,
                                  pickerTextColor: controller.pickerTextColor,
                                  imgs: controller.imgData);
                            } else {
                              appController.updateNote(
                                  titleType:
                                      controller.titleContain ? "ar" : "en",
                                  noteType:
                                      controller.noteContain ? "ar" : "en",
                                  titleController: controller.titleController,
                                  noteController:
                                      controller.noteController.text.isEmpty
                                          ? ""
                                          : controller.noteController,
                                  pickerBGColor: controller.pickerBGColor,
                                  pickerTextColor: controller.pickerTextColor,
                                  id: controller.id,
                                  imgs: controller.imgData);
                            }
                            controller.titleContain = false;
                            controller.noteContain = false;
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainScreen()),
                                (route) => false);
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
