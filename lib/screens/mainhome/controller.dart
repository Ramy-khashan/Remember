import 'package:flutter_bloc/flutter_bloc.dart';
import '../note/view.dart';
import '../todo/view.dart';
import 'state.dart';

class MainHomeController extends Cubit<MainHomeStates> {
  MainHomeController() : super(InitialMainHomeState());
  static MainHomeController get(context) =>
      BlocProvider.of<MainHomeController>(context);
  int index = 0;
  List pages = [
    const NoteScreen(),
    const TodoScreen(),
  ];
  changeIndecator(int val) {
    index = val;
    emit(ChangeIndicatorState());
  }
}
