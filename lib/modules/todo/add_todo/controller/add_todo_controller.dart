import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/constant/app_string.dart';
import '../../../../core/utils/if_arabic_check.dart';
import 'add_todo_states.dart';

class AddingTodoController extends Cubit<AddingTodoState> {
  static AddingTodoController get(context) => BlocProvider.of(context);
  AddingTodoController() : super(InitialAddingTodoState());
  bool headContain = false;
  String headLan = "en";
  String todoId = "";

  TimeOfDay endTime =
      TimeOfDay(hour: TimeOfDay.now().hour + 1, minute: TimeOfDay.now().minute);
  TimeOfDay startTime = TimeOfDay.now();

  String reminderValue = '10 min before';
  DateTime deadLine = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
  DateTime addedAt = DateTime.now();

  final headController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  getTime(context, type, selectTime) {
    showTimePicker(
      context: context,
      initialTime: selectTime,
      initialEntryMode: TimePickerEntryMode.dial,
    ).then((value) {
      log(value!.format(context));
      if (type == "start") {
        startTime = value;
      } else if (type == "end") {
        endTime = value;
      }
      emit(UpdateStartEndTimeState());
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: AppString.chooseTime.tr());
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
      Fluttertoast.showToast(msg: AppString.chooseDeadLine.tr());
    });
  }

  getIdToUpdateTodo(Map task, String type) {
    if (type == "update") {
      headController.text = task["head"];
      todoId = task['id'].toString();
      headLan = task["type"];
      deadLine = DateTime(
          int.parse(task['deadLine'].toString().split('-')[0]),
          int.parse(task['deadLine'].toString().split('-')[1]),
          int.parse(task['deadLine'].toString().split('-')[2]));
      startTime = TimeOfDay(
        hour: task['startTime'].toString().split(" ")[0].split(":")[1] == "PM"
            ? int.parse(
                    task['startTime'].toString().split(" ")[0].split(":")[0]) +
                12
            : int.parse(
                task['startTime'].toString().split(" ")[0].split(":")[0]),
        minute:
            int.parse(task['startTime'].toString().split(" ")[0].split(":")[1]),
      );
      endTime = TimeOfDay(
        hour: task['endTime'].toString().split(" ")[0].split(":")[1] == "PM"
            ? int.parse(
                    task['endTime'].toString().split(" ")[0].split(":")[0]) +
                12
            : int.parse(task['endTime'].toString().split(" ")[0].split(":")[0]),
        minute:
            int.parse(task['endTime'].toString().split(" ")[0].split(":")[1]),
      );
      reminderValue = task["reminder"];
    } else {
      headController.clear();
      headContain = false;
      headLan = "en";
    }
    emit(GetIdTodoState());
  }

  detectLan(String val) {
    if (checkArabic(val)) {
      headLan = "ar";
    } else {
      headLan = "en";
    }
    emit(OnWriteLanguageState());
  }

  textFieldLan(type) {
    String head = headController.text.trim();

    if (!headContain && type == "head" && checkArabic(head)) {
      headContain = true;
    }
    emit(OnWriteLanguageState());
  }
}
