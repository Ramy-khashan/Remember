import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/utils/app_string.dart';
 
import '../../../core/widgets/empty.dart';
import '../../../core/widgets/noteshape.dart';
import '../../../app_intitial/cubit/app_cubit/appcontroller.dart';
import '../../../app_intitial/cubit/app_cubit/appstate.dart';
import '../../view_note/view/view_note_screen.dart';
import '../controller/note_controller.dart';
import '../controller/note_states.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: size.shortestSide * .05,
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
                  ),
                ),
                body: controller.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor),
                      )
                    : controller.notes.isEmpty
                        ? EmptyItem(size: size, text: AppString.noNote.tr())
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              vertical: size.longestSide * .007,
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
                                  size: size,
                                  note: controller.notes[
                                      controller.notes.length - 1 - index],
                                  onDelete: () {
                                    noteController.deleteNote(
                                        context,
                                        size,
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
