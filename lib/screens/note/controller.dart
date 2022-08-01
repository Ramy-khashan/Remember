import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../addingnote/view.dart';
import 'states.dart';

class NoteController extends Cubit<NoteState> {
  NoteController() : super(InitialNoteState());
  static NoteController get(context) => BlocProvider.of(context);
  movingToAddNote(context) {
    Map? note = {};
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddingNoteScreen(
                  type: "add",
                  note: note,
                )));
  }

  updateNote(context, controller, index) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AddingNoteScreen(type: "update", note: controller.notes[index]),
        ));
  }

  deleteNote(context, size, controller, index) {
    AwesomeDialog(
        dismissOnTouchOutside: false,
        dialogType: DialogType.WARNING,
        context: context,
        body: Text(
          "Are you sure delete this item",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: size.shortestSide * .051,
              fontFamily: "todo"),
        ),
        btnCancel: TextButton(
          child: const Text("Delete"),
          onPressed: () {
            controller.deleteNote(
              controller.notes[index]['id'].toString(),
            );
            Navigator.pop(context);
          },
        ),
        btnOk: TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        )).show();
  }
}
