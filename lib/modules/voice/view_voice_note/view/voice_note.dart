import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../config/app/controller/appcontroller.dart';
import '../../../../core/utils/camil_case.dart';
import '../../add_voice_note/view/add_voice_note_screen.dart';
import 'package:voice_message_package/voice_message_package.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_string.dart';
import '../../../../core/components/empty.dart';

class VoiceNoteScreen extends StatelessWidget {
  const VoiceNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppController, AppStates>(
      builder: (context, state) {
        final controller = AppController.get(context);
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            elevation: 12,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0)),
            label: Text(
              AppString.note.tr(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            isExtended: true,
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddVoiceNoteScreen(),
                  ));
            },
            icon: const Icon(
              FontAwesomeIcons.plus,
              color: Colors.white,
              size: 25,
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: controller.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.voiceNote.isEmpty
                        ? EmptyItem(text: AppString.noNote.tr())
                        : ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                            ),
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            camilCaseMethod(controller
                                                .voiceNote[index]["title"]
                                                .toString()),
                                            textAlign: controller
                                                        .voiceNote[index]
                                                            ["titleType"]
                                                        .toString() ==
                                                    "en"
                                                ? TextAlign.left
                                                : TextAlign.right,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              controller.deleteVoiceNote(
                                                  voiceNoteId: controller
                                                      .voiceNote[index]["id"]
                                                      .toString());
                                            },
                                            icon: Icon(
                                              CupertinoIcons.trash,
                                              color: Colors.red.shade800,
                                              size: 30,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.all(10),
                                        child: VoiceMessageView(
                                          activeSliderColor:
                                              AppColor.mainColor3,
                                          circlesColor: AppColor.mainColor3,
                                          backgroundColor: AppColor.mainColor2,
                                          counterTextStyle: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          controller: VoiceController(
                                            audioSrc: controller
                                                .voiceNote[index]["voiceNote"]
                                                .toString(),
                                            maxDuration:
                                                const Duration(minutes: 10),
                                            isFile: true,
                                            onComplete: () {},
                                            onPause: () {},
                                            onPlaying: () {},
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 5,
                                ),
                            itemCount: controller.voiceNote.length),
              ),
            ],
          ),
        );
      },
    );
  }
}
