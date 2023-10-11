import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../add_voice_note/view/add_voice_note_screen.dart';
import 'package:voice_message_package/voice_message_package.dart';
import '../../../app_intitial/cubit/app_cubit/appcontroller.dart';
import '../../../app_intitial/cubit/app_cubit/appstate.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/app_string.dart';
import '../../../core/widgets/empty.dart';

class VoiceNoteScreen extends StatelessWidget {
  const VoiceNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return BlocBuilder<AppController, AppStates>(
      builder: (context, state) {
        final controller = AppController.get(context);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0)),
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddVoiceNoteScreen(),
                    ));
              },
              child: const Icon(
                FontAwesomeIcons.plus,
                color: Colors.white,
              )),
          body: Column(
            children: [
              Expanded(
                child: controller.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.voiceNote.isEmpty
                        ? EmptyItem(
                            size: MediaQuery.of(context).size,
                            text: AppString.noNote.tr())
                        : ListView.separated(
                          shrinkWrap: true,
                             padding: EdgeInsets.symmetric(
                              vertical: size.longestSide * .007,
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
                                            controller.voiceNote[index]["title"]
                                                .toString(),
                                            textAlign: controller
                                                        .voiceNote[index]
                                                            ["titleType"]
                                                        .toString() ==
                                                    "en"
                                                ? TextAlign.left
                                                : TextAlign.right,style: TextStyle(fontSize:MediaQuery.of(context).size.width*.05,fontWeight: FontWeight.w500),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              controller.deleteVoiceNote(
                                                  voiceNoteId: controller
                                                      .voiceNote[index]["id"]
                                                      .toString());
                                            },
                                            icon: const Icon(
                                              FontAwesomeIcons.trash,
                                              color: Colors.red,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 5,),
                                      VoiceMessage(
                                        audioSrc: controller.voiceNote[index]
                                                ["voiceNote"]
                                            .toString(),
                                        me: true,
                                        showDuration: false,
                                        radius: 20,
                                        meBgColor: AppColor.mainColor1,
                                        onPlay: () {},
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
