import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constant/app_string.dart';
import '../../add_note/view/add_note_screen.dart';
import 'note_states.dart';

class NoteController extends Cubit<NoteState> {
  NoteController() : super(InitialNoteState());
  static NoteController get(context) => BlocProvider.of(context);
  movingToAddNote(context) {
    Map? note = {};
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddingNoteScreen(
                  imgList: const [],
                  type: "add",
                  note: note,
                )));
  }

  deleteNote(context, controller, index) {
    AwesomeDialog(
        dismissOnTouchOutside: false,
        dialogType: DialogType.question,
        context: context,
        body: Text(
          AppString.deleteMsg.tr(),
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              fontFamily: "todo"),
        ),
        btnOk: TextButton(
          child: Text(
            AppString.delete.tr(),
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
          onPressed: () {
            controller.deleteNote(
              controller.notes[index]['id'].toString(),
            );
            Navigator.pop(context);
          },
        ),
        btnCancel: TextButton(
          child: Text(
            AppString.cancel.tr(),
            style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w800),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )).show();
  }
}
