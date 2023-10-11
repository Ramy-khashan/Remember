// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart'; 

import '../../../core/utils/app_color.dart';
import '../../../core/utils/app_string.dart';
import '../../../core/widgets/adding_taskinfo_item.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart'; 
import '../../../core/widgets/head.dart';
import '../../../core/widgets/textfield.dart';
import '../../../app_intitial/cubit/app_cubit/appcontroller.dart';
import '../../../app_intitial/cubit/app_cubit/appstate.dart';
import '../../../services/get_duration_minutes.dart';
import '../controller/add_todo_controller.dart';
import '../controller/add_todo_states.dart';

class AddingTaskScreen extends StatelessWidget {
  final String type;
  final Map task;
  const AddingTaskScreen({required this.type, required this.task, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) =>
          AddingTodoController()..getIdToUpdateTodo(task, type),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appbar(
            isArabic: context.locale.toString() == AppString.arabic,
            head: AppString.addTask.tr(),
            size: size,
            context: context,
            changeTheme: false),
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
                              HeadItem(size: size, head: AppString.title.tr()),
                              TextFieldItem(
                                  onChange: (val) {
                                    controller.onChangeTextField(val);
                                  },
                                  valid: AppString.validateMsg.tr(),
                                  isNeedBorder: true,
                                  lan: controller.headLan,
                                  controller: controller.headController,
                                  lable: AppString.title.tr()),
                              HeadItem(
                                  size: size, head: AppString.deadline.tr()),
                              Container(
                                height: size.longestSide * .075,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                ),
                                decoration: BoxDecoration(
                                    color: AppColor.mainColor1.withOpacity(.15),
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
                                        icon: const Icon(
                                          Icons.table_view,
                                          color: AppColor.mainColor2,
                                        ))
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  StartEndTimeItem(
                                      head: AppString.startTime.tr(),
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
                                      head: AppString.endTime.tr(),
                                      time: controller.endTime
                                          .format(context)
                                          .toString(),
                                      onTap: () {
                                        controller.getTime(
                                            context, "end", controller.endTime);
                                      },
                                      size: size),
                                ],
                              ),
                            
                            ],
                          ),
                        ),
                      ),
                      ButtonItem(
                        textSize: .08,
                        head: type == "insert"
                            ? AppString.add.tr()
                            : AppString.update.tr(),
                        onTap: () async {
                          if (controller.formKey.currentState!.validate()) {
                            //todo handel reminder with duration to handel notification

                            controller.textFieldLan("head");

                            if (type == "insert") {
                              await [
                                Permission.notification,
                              ].request();
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
