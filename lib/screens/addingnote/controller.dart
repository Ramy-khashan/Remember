import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'states.dart';

import '../../cubit/appcontroller.dart';
import '../../cubit/appstate.dart';

class AddingNoteController extends Cubit<AddingTaskStates> {
  AddingNoteController() : super(InitialAddingState());
  static AddingNoteController get(ctx) => BlocProvider.of(ctx);
  List letter = [
    "ئ",
    "ء",
    "ؤ",
    "ر",
    "ى",
    "ة",
    "و",
    "ظ",
    "ط",
    "ك",
    "م",
    "ن",
    "ت",
    "ا",
    "ل",
    "ب",
    "ي",
    "س",
    "ش",
    "د",
    "ج",
    "ح",
    "خ",
    "ه",
    "ع",
    "غ",
    "ف",
    "ق",
    "ث",
    "ص",
    "ض",
    "ذ",
    "~",
    "ْ",
    "لآ",
    "آ",
    "ِ",
    "ٍ",
    "أ",
    "،",
    "؛",
    "‘",
    "ٌ",
    "ُ",
    "ً",
    "َ",
    "ّ"
  ];
  String id = "";

  Color pickerBGColor = const Color.fromARGB(0, 0, 0, 0);
  Color pickerTextColor = const Color.fromARGB(255, 255, 255, 255);
  String titleLan = "en";
  String noteLan = "en";
  bool titleContain = false;
  bool noteContain = false;
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  initialValues() {
    titleLan = "en";
    noteLan = "en";
    titleController.clear();
    noteController.clear();
    pickerBGColor = const Color(0xffeeeeee);
    pickerTextColor = const Color(0xff050505);
  }

  textFieldLan(type) {
    String title = titleController.text.trim();
    String note = noteController.text.trim();
    for (int i = 0; i < letter.length; i++) {
      if (type == "note" && note[0] == letter[i] && !noteContain) {
        noteContain = true;
        log("note ar");
        break;
      }
      if (!titleContain && type == "title" && title[0] == letter[i]) {
        titleContain = true;
        break;
      }
    }
    emit(IsContainTodoState());
  }

  void getNoteIdToUpdate(type, Map note) {
    if (type == "update") {
      id = note['id'].toString();
      titleController.text = note['title'];
      noteController.text = note['note'];
      titleLan = note['titleType'];
      noteLan = note['noteType'];
      pickerBGColor =
          Color(int.parse(note['bgColor'].toString().substring(6, 16)));
      pickerTextColor =
          Color(int.parse(note['textColor'].toString().substring(6, 16)));
      emit(GetNoteByIdState());
    }
  }

  detectLan(String val, String type) {
    for (int i = 0; i < letter.length; i++) {
      if (val.trim()[0].toString() == letter[i]) {
        if (type == "title") {
          titleLan = "ar";

          break;
        } else {
          noteLan = "ar";
          break;
        }
      } else {
        if (type == "title") {
          titleLan = "en";
        } else {
          noteLan = "en";
        }
      }
    }
    emit(LanguageState());
  }

  void changeBGColor(Color color, bool isText) {
    if (isText) {
      pickerTextColor = color;
    } else {
      pickerBGColor = color;
    }
    emit(PutColorState());
  }

  showColorPicker(context, bool isText) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Center(
                  child:
                      Text(isText ? 'Pick a Text color!' : 'Pick a BG color!')),
              content: SingleChildScrollView(
                child: ColorPicker(
                    pickerColor: isText ? pickerTextColor : pickerBGColor,
                    onColorChanged: (color) {
                      changeBGColor(color, isText);
                    }),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('Got it'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }
}
