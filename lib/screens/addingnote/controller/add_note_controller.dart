import 'dart:convert'; 
import 'dart:io';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/utils/app_string.dart';
import '../../../data/static_letter.dart';
import '../../../core/widgets/button.dart';
import 'add_note_states.dart';

class AddingNoteController extends Cubit<AddingTaskStates> {
  AddingNoteController() : super(InitialAddingState());
  static AddingNoteController get(ctx) => BlocProvider.of(ctx);
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

  initialValues(List imgList, String type) {
    titleLan = "en";
    noteLan = "en";
    titleController.clear();
    noteController.clear();
    pickerBGColor = const Color(0xffeeeeee);
    pickerTextColor = const Color(0xff050505);
    if (type == "update") {
      imgsConverted = imgList;
      convertoMap();
      
    } else {
      imgsConverted = [];
    }

    emit(EditState());
  }

  textFieldLan(type) {
    String title = titleController.text.trim();
    String note = noteController.text.trim();
    for (int i = 0; i < LetterClass.arabicLetters.length; i++) {
      if (type == "note" &&
          note[0] == LetterClass.arabicLetters[i] &&
          !noteContain) {
        noteContain = true;
      
        break;
      }
      if (!titleContain &&
          type == "title" &&
          title[0] == LetterClass.arabicLetters[i]) {
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
    if (val.trim().isNotEmpty) {
      for (int i = 0; i < LetterClass.arabicLetters.length; i++) {
        if (val.trim()[0].toString() == LetterClass.arabicLetters[i]) {
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

  showColorPicker(context, bool isText, size) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
            child: Text(isText ? 'Pick a Text color!' : 'Pick a BG color!')),
        content: SingleChildScrollView(
          child: ColorPicker(
              pickerColor: isText ? pickerTextColor : pickerBGColor,
              onColorChanged: (color) {
                changeBGColor(color, isText);
              }),
        ),
        actions: [
          ButtonItem(
              onTap: () {
                Navigator.of(context).pop();
              },
              head: AppString.gotIt.tr(),
              size: size)
        ],
      ),
    );
  }

  ///Deleting image
  deleteImage(index) {
    imgsConverted.removeAt(index);
    convertoMap();
    emit(DeletinImageState());
  }

  ///get add Images and convert section
  List<File> imgsFile = [];
  Uint8List? img;
  List imgsConverted = [];
  getImage() async {
    imgsFile = [];
    ImagePicker picker = ImagePicker();
    List<XFile>? value = await picker.pickMultiImage(imageQuality: 100);
    for (XFile element in value) {
      imgsFile.add(File(element.path));
    }
    for (File element in imgsFile) {
      Uint8List imgMultiple = File(element.path).readAsBytesSync();
      String img = base64Encode(imgMultiple);
    
      imgsConverted.add(img);
    }

    convertoMap();
    emit(ConvertFileToBase64State());
  }

  String imgData = "";
  convertoMap() {
    imgData = "";

    List listMap = [];
    if (imgsConverted.isNotEmpty) {
      for (String element in imgsConverted) {
        listMap.add({"img": element});
      }
      Map<String, dynamic> map = {"all": listMap};
      Map<String, dynamic> imgsMap = map;

      imgData = json.encode(imgsMap);
    }
    emit(ConvertToMapToStringState());
  }
}
