import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constant/app_string.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/components/todo_filter_item.dart';
import '../../add_todo/view/add_todo_screen.dart';
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

  fillter(context,  appController) {
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
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TodoFilterItem(
              
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
      {required BuildContext context,  appController}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.only(top: 10),
          height:200,
          child: Column(
            children: [
              Card(
                  child: ListTile(
                leading: Icon(
                  Icons.add,
                  size: 25,
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
                      fontSize: 20,
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
                  size: 25,
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
                      fontSize: 20,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w900,
                      fontFamily: "todo"),
                ),
                onTap: () {
                  Navigator.pop(context);
                  fillter(context, appController);
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
       required int index,
      appController}) {
    AwesomeDialog(
        dialogType: DialogType.question,
        headerAnimationLoop: true,
        context: context,
        body: Text(
         AppString.deleteMsg.tr(),
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 25,
              fontFamily: "todo"),
        ),
        btnCancel: TextButton(
          child:  Text(
            AppString.cancel.tr(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
                    fontSize: 20,
              
            ),
          ),
            onPressed: () {
            Navigator.pop(context);
          },
          
        ),
        btnOk: TextButton(
          child:  Text(
            AppString.delete.tr(),
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w800,
                    fontSize: 20,
              
            ),
          ),  onPressed: () {
            appController.deleteTodo(appController
                .todos[appController.todos.length - index - 1]['id']
                .toString());
            Navigator.pop(context);
          },
        
        )).show();
  }
}
