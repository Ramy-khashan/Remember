import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/app_string.dart';
import '../../addtodo/view/add_todo_screen.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/widgets/empty.dart';
import '../../../core/widgets/todoshape.dart';
import '../../../app_intitial/cubit/app_cubit/appcontroller.dart';
import '../../../app_intitial/cubit/app_cubit/appstate.dart';
import '../controller/todo_controller.dart';
import '../controller/todo_state.dart'; 

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => TodoController(),
      child: BlocBuilder<AppController, AppStates>(
        builder: (context, state) {
          final appController = AppController.get(context);
          return BlocBuilder<TodoController, TodoStates>(
            builder: (context, state) {
              final controller = TodoController.get(context);
              return Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: FloatingActionButton.extended(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0)),
                  label: Text(
                    AppString.task.tr(),
                    style: TextStyle(
                        fontSize: size.shortestSide * .05,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    controller.showBottomSheet(
                        context: context,
                        size: size,
                        appController: appController);
                  },
                ),
                body: appController.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.mainColor1,
                        ),
                      )
                    : (controller.isAll
                            ? appController.todos.isEmpty
                            : controller.isCompelet
                                ? appController.compeletTodos.isEmpty
                                : appController.uncompeletTodos.isEmpty)
                        ? EmptyItem(
                            size: size,
                            text: controller.isAll
                                ? AppString.noMission.tr()
                                : controller.isCompelet
                                    ? AppString.noMissionCom.tr()
                                    : AppString.allMissionComp.tr(),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: controller.isAll
                                ? appController.todos.length
                                : controller.isCompelet
                                    ? appController.compeletTodos.length
                                    : appController.uncompeletTodos.length,
                            itemBuilder: (context, index) {
                               
                              return InkWell(
                                onDoubleTap: () {
                                  controller.showDeletDialog(
                                    context: context,
                                    size: size,
                                    index: index,
                                    appController: appController,
                                  );
                                },
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddingTaskScreen(
                                                  type: "update",
                                                  task: appController.todos[
                                                      appController
                                                              .todos.length -
                                                          index -
                                                          1])));
                                },
                                child: TodoShapeItem(
                                  todo: controller.isAll
                                      ? appController.todos[
                                          appController.todos.length -
                                              index -
                                              1]
                                      : controller.isCompelet
                                          ? appController.compeletTodos[
                                              appController
                                                      .compeletTodos.length -
                                                  index -
                                                  1]
                                          : appController.uncompeletTodos[
                                              appController
                                                      .uncompeletTodos.length -
                                                  index -
                                                  1],
                                  size: size,
                                  onChanged: (val) {
                                    // todo done
                                    controller.onChangeCheckBox(
                                      list: controller.isAll
                                          ? appController.todos
                                          : controller.isCompelet
                                              ? appController.compeletTodos
                                              : appController.uncompeletTodos,
                                      controller: appController,
                                      index: controller.isAll
                                          ? appController.todos.length -
                                              index -
                                              1
                                          : controller.isCompelet
                                              ? appController
                                                      .compeletTodos.length -
                                                  index -
                                                  1
                                              : appController
                                                      .uncompeletTodos.length -
                                                  index -
                                                  1,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
              );
            },
          );
        },
      ),
    );
  }
}
