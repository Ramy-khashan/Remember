import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import '../../main_screen/view/view.dart';

import '../../../app_intitial/cubit/app_cubit/appcontroller.dart';
import '../../../data/static_letter.dart';

part 'add_voice_note_state.dart';

class AddVoiceNoteCubit extends Cubit<AddVoiceNoteState> {
  AddVoiceNoteCubit() : super(AddVoiceNoteInitial());
  static AddVoiceNoteCubit get(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  String titleLan = "en";
  detectLan(String val, String type) {
    if (val.trim().isNotEmpty) {
      for (int i = 0; i < LetterClass.arabicLetters.length; i++) {
        if (val.trim()[0].toString() == LetterClass.arabicLetters[i]) {
          if (type == "title") {
            titleLan = "ar";

            break;
          } else {
            break;
          }
        } else {
          if (type == "title") {
            titleLan = "en";
          } else {}
        }
      }
    }
    emit(LanguageState());
  }

  @override
  Future<void> close() {
    record.dispose();
    isRecording=false;
    return super.close();
  }

  DateTime? startTime;
  Timer? timer;
  String recordDuration = "00:00";
  bool isRecording = false;
  late Record record;
  startRecord() async {
    if (await Record().hasPermission()) {
      isRecording = true;
      record = Record();
      await record.start(
        path:
            "${(await getApplicationDocumentsDirectory()).path}audio_${DateTime.now().millisecondsSinceEpoch}.m4a",
        encoder: AudioEncoder.aacLc,
        bitRate: 128000,
        samplingRate: 44100,
      );
      if (await record.isRecording()) {
        startTime = DateTime.now();
        timer = Timer.periodic(const Duration(seconds: 1), (_) {
          emit(AddVoiceNoteInitial());

          final minDur = DateTime.now().difference(startTime!).inMinutes;
          final secDur = DateTime.now().difference(startTime!).inSeconds % 60;
          String min = minDur < 10 ? "0$minDur" : minDur.toString();
          String sec = secDur < 10 ? "0$secDur" : secDur.toString();

          recordDuration = "$min:$sec";

          emit(GetDuratioState());
        });
      }
    }
  }

  File? file;
  String filePath = "";
  stopRecord() async {
    isRecording = false;
    emit(AddVoiceNoteInitial());

    filePath = (await record.stop())!;
    file = File(filePath);
    recordDuration = "00:00";
    timer?.cancel();
    await record.dispose();

    emit(StopRecorderState());
  }

  restartRecord() async {
    isRecording=false;
    emit(AddVoiceNoteInitial());
    await record.stop();
    record.dispose();

    await record.isRecording();
    filePath = "";
    timer?.cancel();

    recordDuration = "00:00";

    emit(StopRecorderState());
  }

  pauseRecord() async {
    await record.pause();

    emit(PauseRecorderState());
  }

  changeLan(val) {
    if (val.isNotEmpty) {
      detectLan(val, "title");
    } else {
      titleLan = "en";
    }
    emit(LanguageState());
  }

  bool isLoadingAdd = false;
  addVoiceNote(context) async {
    isLoadingAdd = true;
    emit(LoadingAddNoteState());

    await AppController.get(context)
        .insertVoiceNote(
            titleController, titleLan, DateTime.now().toString(), filePath)
        .then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainScreen(initialIndex: 2)),
          (route) => false);
    });
    isLoadingAdd = false;
    emit(AddNoteState());
  }
}
