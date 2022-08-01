import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/appbar.dart';
import '../../components/empty.dart';
import '../../components/noteshape.dart';
import '../../cubit/appcontroller.dart';
import '../../cubit/appstate.dart';
import 'controller.dart';
import 'states.dart';

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
                  appBar: appbar(head: "Note", size: size, context: context),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: FloatingActionButton.extended(
                    label: Text(
                      "Note",
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
                          ? EmptyItem(size: size, text: "No notes")
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                vertical: size.longestSide * .007,
                              ),
                              itemCount: controller.notes.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      noteController.updateNote(
                                          context,
                                          controller,
                                          controller.notes.length - 1 - index);
                                    },
                                    child: NoteShapeItem(
                                        size: size,
                                        note: controller.notes[
                                            controller.notes.length -
                                                1 -
                                                index],
                                        onDelete: () {
                                          noteController.deleteNote(
                                              context,
                                              size,
                                              controller,
                                              controller.notes.length -
                                                  1 -
                                                  index);
                                        }));
                              },
                            ));
            },
          );
        },
      ),
    );
  }
}
