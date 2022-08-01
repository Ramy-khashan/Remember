import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:remember/services/local_notification.dart';

import '../../components/addingtaskinfoItem.dart';
import '../../components/appbar.dart';
import '../../components/button.dart';
import '../../components/dropdownitem.dart';
import '../../components/head.dart';
import '../../components/textfield.dart';
import '../../constant.dart';
import '../../cubit/appcontroller.dart';
import '../../cubit/appstate.dart';
import '../../services/get_duration_minutes.dart';
import 'controller.dart';
import 'states.dart';

class AddingTaskScreen extends StatelessWidget {
  final String type;
  final Map task;
  const AddingTaskScreen({required this.type, required this.task, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => AddingTodoController()
        ..initialValues()
        ..getIdToUpdateTodo(task, type),
      child: Scaffold(
        appBar: appbar(
            head: "Add Task", size: size, context: context, changeTheme: false),
        body: BlocBuilder<AppController, AppStates>(
          builder: (context, state) {
            final appController = AppController.get(context);
            return BlocBuilder<AddingTodoController, AddingTodoState>(
              builder: (context, state) {
                final controller = AddingTodoController.get(context);

                return Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                              vertical: size.longestSide * .005,
                              horizontal: size.shortestSide * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeadItem(size: size, head: 'Title'),
                              TextFieldItem(
                                  onChange: (val) {
                                    controller.onChangeTextField(val);
                                  },
                                  valid: "This field must not be empty",
                                  isNeedBorder: true,
                                  lan: controller.headLan,
                                  controller: controller.headController,
                                  lable: "Title"),
                              HeadItem(size: size, head: 'Deadline'),
                              Container(
                                height: size.longestSide * .075,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                decoration: BoxDecoration(
                                    color: mainColor1.withOpacity(.15),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  children: [
                                    Text(
                                      controller.deadLine
                                          .toLocal()
                                          .toString()
                                          .substring(0, 10),
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          controller.getDeadlineDate(context);
                                        },
                                        icon: Icon(
                                          Icons.table_view,
                                          color: mainColor2,
                                        ))
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  StartEndTimeItem(
                                      head: "Start Time",
                                      time:
                                          controller.startTime.format(context),
                                      onTap: () {
                                        controller.getTime(context, "start",
                                            controller.startTime);
                                      },
                                      size: size),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  StartEndTimeItem(
                                      head: "End Time",
                                      time: controller.endTime.format(context),
                                      onTap: () {
                                        controller.getTime(
                                            context, "end", controller.endTime);
                                      },
                                      size: size),
                                ],
                              ),
                              DropDownListItem(
                                  onChange: (val) {
                                    controller.onChangeReminderValue(val);
                                  },
                                  listType: controller.reminders,
                                  reminderValue: controller.reminderValue,
                                  head: "Reminder",
                                  size: size),
                            ],
                          ),
                        ),
                      ),
                      ButtonItem(
                        textSize: .08,
                        head: type == "insert" ? "add" : "update",
                        onTap: () async {
                          if (controller.formKey.currentState!.validate()) {
                            //todo handel reminder with duration to handel notification

                            await controller.textFieldLan("head");

                            if (type == "insert") {
                              appController.insertTodoItem(
                                  controller.headContain ? "ar" : "en",
                                  controller.headController,
                                  controller.deadLine
                                      .toLocal()
                                      .toString()
                                      .substring(0, 10),
                                  controller.startTime.format(context),
                                  controller.endTime.format(context),
                                  DateFormat.yMd().format(controller.addedAt),
                                  controller.reminderValue,
                                  ControlTime(
                                          deadLineDay: controller.deadLine,
                                          endTime: controller.endTime,
                                          startDay: controller.addedAt,
                                          startTime: controller.startTime)
                                      .calTime());
                            } else {
                              appController.updateTodo(
                                  controller.headContain ? "ar" : "en",
                                  controller.headController,
                                  controller.todoId,
                                  controller.deadLine
                                      .toLocal()
                                      .toString()
                                      .substring(0, 10),
                                  controller.startTime.format(context),
                                  controller.endTime.format(context),
                                  DateFormat.yMd().format(controller.addedAt),
                                  controller.reminderValue,
                                  ControlTime(
                                          deadLineDay: controller.deadLine,
                                          endTime: controller.endTime,
                                          startDay: controller.addedAt,
                                          startTime: controller.startTime)
                                      .calTime());
                            }
                            controller.headContain = false;
                            controller.headLan = "en";
                            Navigator.pop(context);
                          }
                        },
                        size: size,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
