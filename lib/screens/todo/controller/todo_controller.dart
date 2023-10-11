import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/app_string.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/widgets/todo_filter_item.dart';
import '../../addtodo/view/add_todo_screen.dart';
import 'todo_state.dart';

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

  fillter(context, size, appController) {
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
                head: AppString.showAllTask.tr(),
                onTap: () {
                  isAll = true;
                  isCompelet = false;
                  appController.getTodoList();
                  isUnCompelet = false;
                  emit(FilterTaskTodoState());
                  Navigator.pop(context);
                },
              ),
              TodoFilterItem(
                size: size,
                head: AppString.showComplTask.tr(),
                onTap: () {
                  isAll = false;
                  isCompelet = true;
                  appController.getTodoList();
                  isUnCompelet = false;
                  emit(FilterTaskTodoState());
                  Navigator.pop(context);
                },
              ),
              TodoFilterItem(
                size: size,
                head: AppString.showUncomplTask.tr(),
                onTap: () {
                  isAll = false;
                  isCompelet = false;
                  isUnCompelet = true;
                  appController.getTodoList();

                  emit(FilterTaskTodoState());
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  showBottomSheet(
      {required BuildContext context, required Size size, appController}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.only(top: 10),
          height: size.longestSide * .3,
          child: Column(
            children: [
              Card(
                  child: ListTile(
                leading: Icon(
                  Icons.add,
                  size: size.shortestSide * .08,
                    color: Theme.of(context).brightness.index == 1
                          ? AppColor.mainColor2
                          : Colors.white,
                ),
                title: Text(
                  AppString.addTask.tr(),
                  style: TextStyle(
                      color: Theme.of(context).brightness.index == 1
                          ? AppColor.mainColor2
                          : Colors.white,
                      fontSize: size.shortestSide * .055,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                      fontFamily: "todo"),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddingTaskScreen(
                                type: "insert",
                                task: {},
                              )));
                },
              )),
              Card(
                  child: ListTile(
                leading: Icon(
                  Icons.filter_alt_outlined,
                  size: size.shortestSide * .08,
                   color: Theme.of(context).brightness.index == 1
                          ? AppColor.mainColor2
                          : Colors.white,
                ),
                title: Text(
                  AppString.filterTask.tr(),
                  style: TextStyle(
                      color: Theme.of(context).brightness.index == 1
                          ? AppColor.mainColor2
                          : Colors.white,
                      fontSize: size.shortestSide * .055,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w900,
                      fontFamily: "todo"),
                ),
                onTap: () {
                  Navigator.pop(context);
                  fillter(context, size, appController);
                },
              )),
            ],
          ),
        );
      },
    );
  }

  showDeletDialog(
      {required BuildContext context,
      required Size size,
      required int index,
      appController}) {
    AwesomeDialog(
        dialogType: DialogType.warning,
        headerAnimationLoop: true,
        context: context,
        body: Text(
         AppString.deleteMsg.tr(),
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: size.shortestSide * .051,
              fontFamily: "todo"),
        ),
        btnCancel: TextButton(
          child:   Text(AppString.delete.tr()),
          onPressed: () {
            appController.deleteTodo(appController
                .todos[appController.todos.length - index - 1]['id']
                .toString());
            Navigator.pop(context);
          },
        ),
        btnOk: TextButton(
          child:   Text(AppString.cancel.tr()),
          onPressed: () {
            Navigator.pop(context);
          },
        )).show();
  }
}
