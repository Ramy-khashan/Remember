import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remember/constant.dart';
import 'package:remember/screens/addtodo/view.dart';

import '../../components/appbar.dart';
import '../../components/empty.dart';
import '../../components/todoshape.dart';
import '../../cubit/appcontroller.dart';
import '../../cubit/appstate.dart';
import 'controller.dart';
import 'state.dart';

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
                  appBar: appbar(
                    head: "Todo",
                    size: size,
                    context: context,
                    isFillter: true,
                    onFilter: () {
                      controller.fillter(context, size, appController);
                    },
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: FloatingActionButton.extended(
                      label: Text(
                        "Task",
                        style: TextStyle(
                            fontSize: size.shortestSide * .05,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddingTaskScreen(
                                      type: "insert",
                                      task: {},
                                    )));
                      },
                      icon: const Icon(
                        FontAwesomeIcons.plus,
                        color: Colors.white,
                      )),
                  body: appController.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: mainColor1,
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
                                  ? "No mission to do"
                                  : controller.isCompelet
                                      ? "No mission compeleted"
                                      : "All mission compeleted",
                            )
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.isAll
                                  ? appController.todos.length
                                  : controller.isCompelet
                                      ? appController.compeletTodos.length
                                      : appController.uncompeletTodos.length,
                              itemBuilder: (context, index) => InkWell(
                                  onDoubleTap: () {
                                    AwesomeDialog(
                                        dialogType: DialogType.WARNING,
                                        headerAnimationLoop: true,
                                        context: context,
                                        body: Text(
                                          "Are you sure delete this item",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  size.shortestSide * .051,
                                              fontFamily: "todo"),
                                        ),
                                        btnCancel: TextButton(
                                          child: const Text("Delete"),
                                          onPressed: () {
                                            appController.deleteTodo(
                                                appController.todos[
                                                        appController
                                                                .todos.length -
                                                            index -
                                                            1]['id']
                                                    .toString());
                                            Navigator.pop(context);
                                          },
                                        ),
                                        btnOk: TextButton(
                                          child: const Text("Cancel"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )).show();
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
                                    //todo not working
                                  },
                                  child: TodoShapeItem(
                                      todo: controller.isAll
                                          ? appController.todos[
                                              appController.todos.length -
                                                  index -
                                                  1]
                                          : controller.isCompelet
                                              ? appController.compeletTodos[
                                                  appController.compeletTodos
                                                          .length -
                                                      index -
                                                      1]
                                              : appController.uncompeletTodos[
                                                  appController.uncompeletTodos
                                                          .length -
                                                      index -
                                                      1],
                                      size: size,
                                      onChanged: (val) {
                                        // todo done
                                        controller.onChangeCheckBox(
                                            list: controller.isAll
                                                ? appController.todos
                                                : controller.isCompelet
                                                    ? appController
                                                        .compeletTodos
                                                    : appController
                                                        .uncompeletTodos,
                                            controller: appController,
                                            index: controller.isAll
                                                ? appController.todos.length -
                                                    index -
                                                    1
                                                : controller.isCompelet
                                                    ? appController
                                                            .compeletTodos
                                                            .length -
                                                        index -
                                                        1
                                                    : appController
                                                            .uncompeletTodos
                                                            .length -
                                                        index -
                                                        1);
                                      })),
                            ),
                );
              },
            );
          },
        ));
  }
}
