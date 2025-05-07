import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../config/app/controller/appcontroller.dart';
import '../../../../core/constant/app_color.dart';
import 'widgets/audio_controller_shape.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../../../../core/constant/app_string.dart';
import '../../../../core/components/appbar.dart';
import '../../../../core/components/button.dart';
import '../../../../core/components/textfield.dart';
import '../controller/add_voice_note_cubit.dart';

class AddVoiceNoteScreen extends StatelessWidget {
  const AddVoiceNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return BlocProvider(
      create: (context) => AddVoiceNoteCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appbar(
            isArabic: context.locale.toString() == AppString.arabic,
             head: AppString.addNote.tr(),
            context: context,
            changeTheme: false),
        body: BlocBuilder<AddVoiceNoteCubit, AddVoiceNoteState>(
          builder: (context, state) {
            final controller = AddVoiceNoteCubit.get(context);
            return BlocBuilder<AppController, AppStates>(
              builder: (context, state) {
                return SafeArea(
                  top: false,
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        TextFieldItem(
                            onChange: (val) {
                              controller.changeLan(val);
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
                        Expanded(
                            child: Column(
                          children: [
                            controller.filePath.isEmpty
                                ? const SizedBox()
                                : Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.all(10),
                                    child: VoiceMessageView(
                                      activeSliderColor: AppColor.mainColor3,
                                      circlesColor: AppColor.mainColor3,
                                      backgroundColor: AppColor.mainColor2,
                                      counterTextStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      controller: VoiceController(
                                          audioSrc: controller.filePath,
                                          maxDuration:
                                              const Duration(minutes: 10),
                                          isFile: true,
                                          onComplete: () {},
                                          onPause: () {},
                                          onPlaying: () {}),
                                    ),
                                  ),
                            Expanded(
                                child: Center(
                                    child: Text(
                              controller.recordDuration,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ))),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  RecordControlleshape(
                                      heroTag: "tag1",
                                      onTap: () {
                                        controller.restartRecord();
                                      },
                                      icon: FontAwesomeIcons.arrowsRotate,
                                      size: 25),
                                  controller.isRecording
                                      ? const SizedBox.shrink()
                                      : RecordControlleshape(
                                          heroTag: "tag2",
                                          onTap: () {
                                            controller.startRecord();
                                          },
                                          icon:
                                              FontAwesomeIcons.microphoneLines,
                                          size: 35),
                                  if (controller.isRecording)
                                    RecordControlleshape(
                                        heroTag: "tag3",
                                        onTap: () {
                                          controller.stopRecord();
                                        },
                                        icon: FontAwesomeIcons.pause,
                                        size: 25),
                                ],
                              ),
                            ),
                            controller.filePath.isEmpty
                                ? const SizedBox()
                                : controller.isLoadingAdd
                                    ? Center(
                                        child: CircularProgressIndicator(
                                            color:
                                                Theme.of(context).primaryColor),
                                      )
                                    : ButtonItem(
                                       
                                        head: AppString.add.tr(),
                                        onTap: () async {
                                          if (controller.formKey.currentState!
                                              .validate()) {
                                            await controller
                                                .addVoiceNote(context);
                                          }
                                        },
                                      )
                          ],
                        ))
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
