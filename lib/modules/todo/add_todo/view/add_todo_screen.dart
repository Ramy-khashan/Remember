// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../config/app/controller/appcontroller.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_string.dart';
import '../../../../core/components/adding_taskinfo_item.dart';
import '../../../../core/components/appbar.dart';
import '../../../../core/components/button.dart';
import '../../../../core/components/head.dart';
import '../../../../core/utils/get_duration_minutes.dart';
import '../../../../core/components/textfield.dart';
import '../controller/add_todo_controller.dart';
import '../controller/add_todo_states.dart';

class AddingTaskScreen extends StatelessWidget {
  final String type;
  final Map task;
  const AddingTaskScreen({required this.type, required this.task, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddingTodoController()..getIdToUpdateTodo(task, type),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appbar(
            isArabic: context.locale.toString() == AppString.arabic,
            head: AppString.addTask.tr(),
            context: context,
            changeTheme: false),
        body: BlocBuilder<AppController, AppStates>(
          builder: (context, state) {
            final appController = AppController.get(context);
            return BlocBuilder<AddingTodoController, AddingTodoState>(
              builder: (context, state) {
                final controller = AddingTodoController.get(context);

                return SafeArea(
                  top: false,
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeadItem(head: AppString.title.tr()),
                                TextFieldItem(
                                    onChange: (val) {
                                      controller.onChangeTextField(val);
                                    },
                                    valid: AppString.validateMsg.tr(),
                                    isNeedBorder: true,
                                    lan: controller.headLan,
                                    controller: controller.headController,
                                    lable: AppString.title.tr()),
                                HeadItem(head: AppString.deadline.tr()),
                                Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                  ),
                                  decoration: BoxDecoration(
                                      color:
                                          AppColor.mainColor1.withOpacity(.15),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    children: [
                                      Text(
                                        controller.deadLine
                                            .toLocal()
                                            .toString()
                                            .substring(0, 10),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
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
                                    ),
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
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        ButtonItem(
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
                        ),
                      ],
                    ),
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
