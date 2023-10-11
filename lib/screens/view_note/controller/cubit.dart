import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../addingnote/view/add_note_screen.dart';
part 'state.dart';

class ViewNoteCubit extends Cubit<ViewNoteState> {
  ViewNoteCubit() : super(ViewNoteInitial());
  static ViewNoteCubit get(ctx) => BlocProvider.of(ctx);
  updateNote({context, note, imgList}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddingNoteScreen(type: "update", note: note, imgList: imgList),
      ),
    );
  }

  bool isLoading = false;
  Map imgs = {};
  List<String> imgsBase64 = [];
  convertImages(images) {
    imgsBase64 = [];
    isLoading = true;
    emit(StartLoadingState());
    if (images.isNotEmpty) {
      imgs = jsonDecode(images);
      for (var element in imgs['all']) {
        imgsBase64.add(element['img']);
      }
    }
    isLoading = false;
    emit(GetImageToViewState());
  }
}
