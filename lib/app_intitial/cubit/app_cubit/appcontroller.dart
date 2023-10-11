import 'package:alarm/alarm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'appstate.dart';

class AppController extends Cubit<AppStates> {
  AppController() : super(InitialAppState());

  static AppController get(context) => BlocProvider.of(context);

  late Database database;

  bool isLoading = false;
  List<Map<String, Object?>> notes = [];
  List<Map<String, Object?>> todos = [];
  List<Map<String, Object?>> voiceNote = [];
  List<Map<String, Object?>> compeletTodos = [];
  List<Map<String, Object?>> uncompeletTodos = [];
  String date = DateFormat.yMd().format(DateTime.now());
  String time = DateFormat.jm().format(DateTime.now());
  void initialDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'note.db');
    await openDatebase(path);
    emit(InitialDatabaseState());
  }

  Future<void> openDatebase(String path) async {
    await openDatabase(
      path,
      version: 3,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute('CREATE TABLE note (id INTEGER PRIMARY KEY,'
            ' title TEXT, note TEXT, date TEXT, time TEXT,'
            'titleType TEXT,noteType TEXt,bgColor TEXt,'
            'textColor TEXt,imgs TEXt)');
        emit(CreateDatabaseState());
        await db.execute('CREATE TABLE todo (id INTEGER PRIMARY KEY,'
            ' head TEXT, isDone INTEGER, date TEXT, time TEXT,'
            'type TEXT,deadLine TEXT,startTime TEXT,'
            'endTime TEXT,addedAt TEXT,reminder TEXT)');
        emit(CreateDatabaseState());
        await db.execute('CREATE TABLE voice (id INTEGER PRIMARY KEY,'
            ' title TEXT, voiceNote TEXT,'
            'titleType TEXT,addedAt TEXT)');
        emit(CreateVoiceNoteDatabaseState());
      },
      onOpen: (Database db) {
        database = db;
        emit(OpenDatabaseState());
        getNotes();
        getTodoList();
        getVoiceNoteList();
      },
    );
  }

  //note Sql method
  void insertNote(
      {titleType,
      noteType,
      titleController,
      noteController,
      pickerBGColor,
      pickerTextColor,
      imgs}) async {
    emit(RefreshState());
    await database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO note (title, note, date,'
          ' time,titleType,noteType,bgColor,textColor,imgs)'
          ' VALUES(?,?,?,?,?,?,?,?,?)',
          [
            titleController.text.trim(),
            noteController.text.trim(),
            date,
            time,
            titleType,
            noteType,
            pickerBGColor.toString(),
            pickerTextColor.toString(),
            imgs
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

  void updateNote(
      {titleType,
      noteType,
      titleController,
      noteController,
      pickerBGColor,
      pickerTextColor,
      id,
      imgs}) async {
    await database.rawUpdate(
        'UPDATE note SET title = ? ,note = ?, date= ?,'
        ' time= ?,titleType=?,noteType=?,bgColor=?,'
        ' textColor=?, imgs=? WHERE id = $id',
        [
          titleController.text.trim(),
          noteController.text.trim(),
          date,
          time,
          titleType,
          noteType,
          pickerBGColor.toString(),
          pickerTextColor.toString(),
          imgs
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
    TextEditingController headController,
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
          ]).then((value) async {
        List time = deadLine.toString().split("-");
        AlarmSettings buildAlarmSettings() {
          DateTime dateTime = DateTime(
            int.parse(time[0]),
            int.parse(time[1]),
            int.parse(time[2]),
            endTime.toString().contains("PM")
                ? int.parse(endTime.toString().split(":")[0]) + 12
                : int.parse(endTime.toString().split(":")[0]),
            int.parse(endTime.toString().split(":")[1].split(" ")[0]),
          );

          final alarmSettings = AlarmSettings(
            id: value,
            dateTime: dateTime,
            loopAudio: false,
            vibrate: true,
            notificationTitle: 'Remember Task',
            notificationBody: headController.text.trim(),
          assetAudioPath: "assets/music/mozart.wav",
            stopOnNotificationOpen: false,
          );
          return alarmSettings;
        }

        await Alarm.set(alarmSettings: buildAlarmSettings());

        Fluttertoast.showToast(msg: "Mission Added");
        getTodoList();
        emit(InserttodoToDatabaseState());
      }).onError((error, stackTrace) {
        debugPrint("loll : $error");
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
        ]).then((value) async {
      await Alarm.stop(int.parse(todoId));

      List time = deadLine.toString().split("-");
      AlarmSettings buildAlarmSettings() {
        DateTime dateTime = DateTime(
          int.parse(time[0]),
          int.parse(time[1]),
          int.parse(time[2]),
          endTime.toString().contains("PM")
              ? int.parse(endTime.toString().split(":")[0]) + 12
              : int.parse(endTime.toString().split(":")[0]),
          int.parse(endTime.toString().split(":")[1].split(" ")[0]),
        );

        final alarmSettings = AlarmSettings(
          id: todoId,
          dateTime: dateTime,
          loopAudio: false,
          vibrate: true,
          notificationTitle: 'Remember Task',
          notificationBody: headController.text.trim(),
          assetAudioPath: "assets/music/mozart.wav",
          stopOnNotificationOpen: false,
        );
        return alarmSettings;
      }

      await Alarm.set(alarmSettings: buildAlarmSettings());
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
        .then((value) async {
      // NotificationService().cancelNotification(id: ));
      await Alarm.stop(int.parse(todoId));
      Fluttertoast.showToast(msg: "Deleted");
      getTodoList();
      emit(DeleteNoteToDatabaseState());
    });
  }

  updateMissionDone(int type, Map todo) async {
    await database
        .rawUpdate('UPDATE todo SET isDone = ? WHERE id = ${todo["id"]}', [
      type,
    ]).then((value) async {
      if(type==1){
Alarm.stop(        todo["id"]);
      }else{
        // CREATE TABLE todo (id INTEGER PRIMARY KEY,'
        //     ' head TEXT, isDone INTEGER, date TEXT, time TEXT,'
        //     'type TEXT,deadLine TEXT,startTime TEXT,'
        //     'endTime TEXT,addedAt TEXT,reminder TEXT
        //     todo["endTime"]
      List time =  todo["id"].toString().split("-");
      AlarmSettings buildAlarmSettings() {
        DateTime dateTime = DateTime(
          int.parse(time[0]),
          int.parse(time[1]),
          int.parse(time[2]),
          todo["endTime"].toString().contains("PM")
              ? int.parse(todo["endTime"].toString().split(":")[0]) + 12
              : int.parse(todo["endTime"].toString().split(":")[0]),
          int.parse(todo["endTime"].toString().split(":")[1].split(" ")[0]),
        );

        final alarmSettings = AlarmSettings(
          id:  todo["id"],
          dateTime: dateTime,
          loopAudio: false,
          vibrate: true,
          notificationTitle: 'Remember Task',
          notificationBody:todo["date"],
          assetAudioPath: "assets/music/mozart.wav",
          stopOnNotificationOpen: false,
        );
        return alarmSettings;
      }

      await Alarm.set(alarmSettings: buildAlarmSettings());
      }
      Fluttertoast.showToast(msg: type == 1 ? "Completed" : "Not Completed");
      //  headController.clear();

      getTodoList();
      emit(UpdateNoteToDatabaseState());
    });
  }

  /// voice note sql method
  Future<void> insertVoiceNote(
    TextEditingController title,
    String titleType,
    String addedAt,
    String voiceNote,
  ) async {
    await database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO voice (title, voiceNote, titleType, addedAt) VALUES(?,?,?,?)',
          [
            title.text.trim(),
            voiceNote,
            titleType,
            addedAt,
          ]).then((value) {
        Fluttertoast.showToast(msg: "Voice Note Added");
        getVoiceNoteList();
        emit(InserttodoToDatabaseState());
      }).onError((error, stackTrace) {
        debugPrint("loll : $error");

        Fluttertoast.showToast(msg: "Something went wrong try again!");
      });
    });
  }

  void getVoiceNoteList() async {
    isLoading = true;
    emit(LoadingDatabaseState());
    await database.rawQuery('SELECT * FROM voice').then((value) {
      voiceNote = value.reversed.toList();

      isLoading = false;
      emit(SuccesGetTodoToDatabaseState());
    }).onError((error, stackTrace) {
      isLoading = false;
      emit(FaildGetDatabaseState());
    });
  }

  void deleteVoiceNote({required String voiceNoteId}) async {
    await database
        .rawDelete('DELETE FROM voice WHERE id = $voiceNoteId')
        .then((value) {
      Fluttertoast.showToast(msg: "Deleted");
      getVoiceNoteList();
      emit(DeleteNoteToDatabaseState());
    });
  }
}
