import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'states.dart';

class AddingTodoController extends Cubit<AddingTodoState> {
  static AddingTodoController get(context) => BlocProvider.of(context);
  AddingTodoController() : super(InitialAddingTodoState());
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
  bool headContain = false;
  String headLan = "en";
  String todoId = "";

  TimeOfDay endTime =
      TimeOfDay(hour: TimeOfDay.now().hour + 1, minute: TimeOfDay.now().minute);
  TimeOfDay startTime = TimeOfDay.now();
  List<String> reminders = [
    "1 day before",
    "1 hour before",
    "30 min before",
    "10 min before"
  ];
  String reminderValue = '10 min before';
  DateTime deadLine = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1); 
      DateTime addedAt = DateTime.now();

  final headController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  getTime(context, type,selectTime) {
    showTimePicker(
      context: context,
      initialTime: selectTime,
      initialEntryMode: TimePickerEntryMode.dial,
    ).then((value) {
      if (type == "start") {
        startTime = value!;
      } else if (type == "end") {
        endTime = value!;
      }
      emit(UpdateStartEndTimeState());
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: "Choose the time");
    });
  }

  onChangeTextField(val) {
    if (val.isNotEmpty) {
      detectLan(val);
    } else {
      headLan = "en";
    }
    emit(OnWriteLanguageState());
  }

  onChangeReminderValue(val) {
    reminderValue = val;
    emit(ReminderValueState());
  }

  getDeadlineDate(context) {
    showDatePicker(
            context: context,
            initialDate: deadLine,
            firstDate: DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day),
            lastDate: DateTime(DateTime.now().year + 1, 1, 1))
        .then((value) {
      deadLine = value!;
      emit(UpdateDeadlineState());
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: "Shoud choose the deadline day");
    });
  }

  getIdToUpdateTodo(Map task, String type) {
    if (type == "update") {
      headController.text = task["head"];
      todoId = task['id'].toString();
      headLan = task["type"];
      emit(GetIdTodoState());
    }
  }

  detectLan(String val) {
    for (int i = 0; i < letter.length; i++) {
      if (val.trim()[0].toString() == letter[i]) {
        headLan = "ar";
        break;
      } else {
        headLan = "en";
      }
      emit(OnWriteLanguageState());
    }
  }

  textFieldLan(type) {
    String head = headController.text.trim();
    for (int i = 0; i < letter.length; i++) {
      if (!headContain && type == "head" && head[0] == letter[i]) {
        headContain = true;
        break;
      }
    }
    emit(OnWriteLanguageState());
  }

  initialValues() {
    headContain = false;
    headLan = "en";
    headController.clear();
  }
}
