import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remember/components/addingtaskinfoItem.dart';
import 'package:remember/components/dropdownitem.dart';
import 'package:remember/components/head.dart';
import 'package:remember/components/todofilterItem.dart';
import 'package:remember/constant.dart';
import '../../components/button.dart';
import '../../components/textfield.dart';
import '../../cubit/appcontroller.dart';
import '../../cubit/appstate.dart';
import 'state.dart';

class TodoController extends Cubit<TodoStates> {
  TodoController() : super(InitialTodoState());
  static TodoController get(context) => BlocProvider.of(context);
  onChangeCheckBox({list, controller, index}) {
    if (list[index]["isDone"] == 0) {
      controller.updateMissionDone(1, list[index]);
    } else {
      controller.updateMissionDone(0, list[index]);
    }
    emit(CompeletTaskTodoState());
  }

  bool isAll = true;
  bool isCompelet = false;
  bool isUnCompelet = false;

  fillter(context, size, AppController) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 30,
              insetPadding: EdgeInsets.zero,
              content: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).brightness.index == 0
                      ? Colors.white.withOpacity(.8)
                      : Colors.black54,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TodoFilterItem(
                      size: size,
                      head: "Show All Tasks",
                      onTap: () {
                        isAll = true;
                        isCompelet = false;
                        AppController.getTodoList();
                        isUnCompelet = false;
                        emit(FilterTaskTodoState());
                        Navigator.pop(context);
                      },
                    ),
                    TodoFilterItem(
                      size: size,
                      head: "Show Compeleted Tasks",
                      onTap: () {
                        isAll = false;
                        isCompelet = true;
                        AppController.getTodoList();
                        isUnCompelet = false;
                        emit(FilterTaskTodoState());
                        Navigator.pop(context);
                      },
                    ),
                    TodoFilterItem(
                      size: size,
                      head: "Show Uncompeleted Tasks",
                      onTap: () {
                        isAll = false;
                        isCompelet = false;
                        isUnCompelet = true;
                        AppController.getTodoList();

                        emit(FilterTaskTodoState());
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ));
  }
}
