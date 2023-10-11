import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/app_string.dart';
import '../../addingnote/view/add_note_screen.dart';
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


  deleteNote(context, size, controller, index) {
    AwesomeDialog(
        dismissOnTouchOutside: false,
        dialogType: DialogType.warning,
        context: context,
        body: Text(
         AppString.deleteMsg.tr(),
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: size.shortestSide * .051,
              fontFamily: "todo"),
        ),
        btnCancel: TextButton(
          child:   Text(AppString.delete.tr()),
          onPressed: () {
            controller.deleteNote(
              controller.notes[index]['id'].toString(),
            );
            Navigator.pop(context);
          },
        ),
        btnOk: TextButton(
          child:   Text(AppString.cancel.tr()),
          onPressed: () {
            Navigator.pop(context);
          },
        )).show();
  }
}
