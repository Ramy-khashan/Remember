import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../config/app/controller/appcontroller.dart';
import '../../../../core/constant/app_string.dart';
 
import '../../../../core/components/empty.dart';
import '../../../../core/components/noteshape.dart';
 import '../../preview_note/view/view_note_screen.dart';
import '../controller/note_controller.dart';
import '../controller/note_states.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return BlocProvider(
      create: (context) => NoteController(),
      child: BlocBuilder<AppController, AppStates>(
        builder: (context, state) {
          final controller = AppController.get(context);
          return BlocBuilder<NoteController, NoteState>(
            builder: (context, state) {
              final noteController = NoteController.get(context);
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
                    noteController.movingToAddNote(context);
                  },
                  icon: const Icon(
                    FontAwesomeIcons.plus,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                body: controller.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor),
                      )
                    : controller.notes.isEmpty
                        ? EmptyItem(  text: AppString.noNote.tr())
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                            itemCount: controller.notes.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ViewNoteScreen(
                                              note: controller.notes[
                                                  controller.notes.length -
                                                      1 -
                                                      index])));
                                },
                                child: NoteShapeItem(
                                   note: controller.notes[
                                      controller.notes.length - 1 - index],
                                  onDelete: () {
                                    noteController.deleteNote(
                                        context,
                                         controller,
                                        controller.notes.length - 1 - index);
                                  },
                                ),
                              );
                            },
                          ),
              );
            },
          );
        },
      ),
    );
  }
}
