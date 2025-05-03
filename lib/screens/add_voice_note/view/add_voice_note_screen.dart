import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/utils/app_color.dart';
import 'widgets/audio_controller_shape.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../../../app_intitial/cubit/app_cubit/appcontroller.dart';
import '../../../app_intitial/cubit/app_cubit/appstate.dart';
import '../../../core/utils/app_string.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/textfield.dart';
import '../controller/add_voice_note_cubit.dart';

class AddVoiceNoteScreen extends StatelessWidget {
  const AddVoiceNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AddVoiceNoteCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appbar(
            isArabic: context.locale.toString() == AppString.arabic,
            size: size,
            head: AppString.addNote.tr(),
            context: context,
            changeTheme: false),
        body: BlocBuilder<AddVoiceNoteCubit, AddVoiceNoteState>(
          builder: (context, state) {
            final controller = AddVoiceNoteCubit.get(context);
            return BlocBuilder<AppController, AppStates>(
              builder: (context, state) {
                return Form(
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
                                  margin: const EdgeInsets.all(10),
                                  child: VoiceMessageView(
                                    backgroundColor: AppColor.mainColor1,
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
                                  child: Text(controller.recordDuration))),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                RecordControlleshape(
                                    heroTag: "tag1",
                                    onTap: () {
                                      // controller.restartRecord();
                                    },
                                    icon: FontAwesomeIcons.arrowsRotate,
                                    size: 25),
                                controller.isRecording
                                    ? const SizedBox()
                                    : RecordControlleshape(
                                        heroTag: "tag2",
                                        onTap: () {
                                          // controller.startRecord();
                                        },
                                        icon: FontAwesomeIcons.microphoneLines,
                                        size: 35),
                                if (controller.isRecording)
                                  RecordControlleshape(
                                      heroTag: "tag3",
                                      onTap: () {
                                        // controller.stopRecord();
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
                                      textSize: .08,
                                      size: size,
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
                );
              },
            );
          },
        ),
      ),
    );
  }
}
