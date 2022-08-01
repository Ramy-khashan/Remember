import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../services/local_notification.dart';
import 'appstate.dart';

class AppController extends Cubit<AppStates> {
  AppController() : super(InitialAppState());

  static AppController get(context) => BlocProvider.of(context);
  List<String> reminders = [
    "1 day before",
    "1 hour before",
    "30 min before",
    "10 min before"
  ];
  late Database database;

  bool isLoading = false;
  List<Map<String, Object?>> notes = [];
  List<Map<String, Object?>> todos = [];
  List<Map<String, Object?>> compeletTodos = [];
  List<Map<String, Object?>> uncompeletTodos = [];
  String date = DateFormat.yMd().format(DateTime.now());
  String time = DateFormat.jm().format(DateTime.now());
  void initialDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'note.db');
    openDatebase(path);
    emit(InitialDatabaseState());
  }

  void openDatebase(String path) async {
    await openDatabase(
      path,
      version: 2,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE note (id INTEGER PRIMARY KEY, title TEXT, note TEXT, date TEXT, time TEXT,titleType TEXT,noteType Text,bgColor TEXt,textColor Text)');
        emit(CreateDatabaseState());
        await db.execute(
            'CREATE TABLE todo (id INTEGER PRIMARY KEY, head TEXT, isDone INTEGER, date TEXT, time TEXT,type TEXT,deadLine TEXT,startTime TEXT,endTime TEXT,addedAt TEXT,reminder TEXT)');
        emit(CreateDatabaseState());
      },
      onOpen: (Database db) {
        database = db;
        emit(OpenDatabaseState());
        getNotes();
        getTodoList();
      },
    );
  }

  //note Sql method
  void insertNote(titleType, noteType, titleController, noteController,
      pickerBGColor, pickerTextColor) async {
    emit(RefreshState());
    await database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO note (title, note, date, time,titleType,noteType,bgColor,textColor) VALUES(?,?,?,?,?,?,?,?)',
          [
            titleController.text.trim(),
            noteController.text.trim(),
            date,
            time,
            titleType,
            noteType,
            pickerBGColor.toString(),
            pickerTextColor.toString(),
          ]);
    }).then((value) {
      titleController.clear();
      noteController.clear();

      pickerBGColor = const Color.fromARGB(0, 0, 0, 0);
      pickerTextColor = const Color.fromARGB(255, 255, 255, 255);

      Fluttertoast.showToast(msg: "Note Added");
      getNotes();
      emit(InsertNoteToDatabaseState());
    });
  }

  void getNotes() async {
    isLoading = true;
    emit(LoadingDatabaseState());
    await database.rawQuery('SELECT * FROM note').then((value) {
      notes = value;
      isLoading = false;
      emit(SuccesGetNoteToDatabaseState());
    }).onError((error, stackTrace) {
      isLoading = false;
      emit(FaildGetDatabaseState());
    });
  }

  void updateNote(titleType, noteType, titleController, noteController,
      pickerBGColor, pickerTextColor, id) async {
    await database.rawUpdate(
        'UPDATE note SET title = ? ,note = ?, date= ?, time= ?,titleType=?,noteType=?,bgColor=?, textColor=? WHERE id = $id',
        [
          titleController.text.trim(),
          noteController.text.trim(),
          date,
          time,
          titleType,
          noteType,
          pickerBGColor.toString(),
          pickerTextColor.toString(),
        ]).then((value) {
      Fluttertoast.showToast(msg: "Note Updated");
      getNotes();
      emit(UpdateNoteToDatabaseState());
    });
  }

  void deleteNote(String noteId) async {
    await database
        .rawDelete('DELETE FROM note WHERE id = $noteId')
        .then((value) {
      Fluttertoast.showToast(msg: "Note Deleted");
      getNotes();
      emit(DeleteNoteToDatabaseState());
    });
  }

//------------------------------
//#todo sql method
  void insertTodoItem(
    lanType,
    headController,
    deadLine,
    startTime,
    endTime,
    addedAt,
    reminder,
    duration,
  ) async {
    await database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO todo (head, isDone, date, time,type,deadLine,startTime,endTime,addedAt,reminder) VALUES(?,?,?,?,?,?,?,?,?,?)',
          [
            headController.text,
            0,
            date,
            time,
            lanType,
            deadLine,
            startTime,
            endTime,
            addedAt,
            reminder,
          ]).then((value) {
        log(duration.toString());
        NotificationService().showNotification(
            id: value,
            title: "Remember",
            body: headController.text,
            minute: reminder == reminders[0]
                // AddTaskData.reminder[0] == after one day
                ? (duration - (24 * 60))
                : reminder == reminders[1]
                    //  reminder[1] == after one hour
                    ? duration - 60
                    : reminder == reminders[2]
                        //  reminder[2] == after 30 minutes
                        ? duration - 30
                        //  reminder[3] == after 10 minutes
                        : duration - 10);
        Fluttertoast.showToast(msg: "Mission Added");
        getTodoList();
        emit(InserttodoToDatabaseState());
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(msg: "Something went wrong try again!");
      });
    });
  }

  void getTodoList() async {
    uncompeletTodos = [];
    compeletTodos = [];
    isLoading = true;
    emit(LoadingDatabaseState());
    await database.rawQuery('SELECT * FROM todo').then((value) {
      todos = value;
      for (var element in value) {
        if (element['isDone'] == 0) {
          uncompeletTodos.add(element);
        } else if (element['isDone'] == 1) {
          compeletTodos.add(element);
        }
      }
      isLoading = false;
      emit(SuccesGetTodoToDatabaseState());
    }).onError((error, stackTrace) {
      isLoading = false;
      emit(FaildGetDatabaseState());
    });
  }

  void updateTodo(type, headController, todoId, deadLine, startTime, endTime,
      addedAt, reminder, duration) async {
    await database.rawUpdate(
        'UPDATE todo SET head = ? ,isDone = ?,date= ?, time= ?,type=?,deadLine=?,startTime=? ,endTime=?,addedAt=?,reminder=? WHERE id = $todoId',
        [
          headController.text,
          0,
          date,
          time,
          type,
          deadLine,
          startTime,
          endTime,
          addedAt,
          reminder,
        ]).then((value) {
      NotificationService().cancelNotification(int.parse(todoId));
      NotificationService().showNotification(
          id: value,
          title: "Remember",
          body: headController.text,
          minute: duration);
      //todo cancel notification and and add agein
      Fluttertoast.showToast(msg: "Updated");
      type = "";
      headController.clear();
      getTodoList();
      emit(UpdateNoteToDatabaseState());
    });
  }

  void deleteTodo(String todoId) async {
    await database
        .rawDelete('DELETE FROM todo WHERE id = $todoId')
        .then((value) {
      NotificationService().cancelNotification(int.parse(todoId));
      Fluttertoast.showToast(msg: "Deleted");
      getTodoList();
      emit(DeleteNoteToDatabaseState());
    });
  }

  updateMissionDone(int type, Map todo) async {
    await database.rawUpdate(
        'UPDATE todo SET head = ? ,isDone = ?,date= ?, time= ?,type=?,deadLine=?,startTime=? ,endTime=?,addedAt=?,reminder=? WHERE id = ${todo["id"]}',
        [
          todo["head"],
          type,
          todo['date'],
          todo["time"],
          todo["type"],
          todo["deadLine"],
          todo["startTime"],
          todo["endTime"],
          todo["addedAt"],
          todo["reminder"]
        ]).then((value) {
      Fluttertoast.showToast(msg: type == 1 ? "Completed" : "Not Completed");
      //  headController.clear();

      getTodoList();
      emit(UpdateNoteToDatabaseState());
    });
  }

  //-----------------------
  //is Arabic
}
