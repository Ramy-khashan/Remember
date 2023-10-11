import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/app_string.dart';
import '../../note/view/note_screen.dart';
import '../../todo/view/todo_screen.dart';
import '../../voice_note/view/voice_note.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../../setting/view/settng_screen.dart';
import '../model/drawer_model.dart';

part 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(MainScreenInitial());
  static MainScreenCubit get(context) => BlocProvider.of(context);
  List<Widget> screens = [
    const NoteScreen(),
    const TodoScreen(),
    const VoiceNoteScreen(),
    const SettingScreen(),
  ];
  List<DrawerModel> screenTitle = [
    DrawerModel(title: "note".tr(), icon: Icons.note_alt_outlined),
    DrawerModel(title: AppString.todo.tr(), icon: Icons.task_outlined),
    DrawerModel(title: AppString.voiceNote.tr(), icon: Icons.voice_chat),
    DrawerModel(title: AppString.setting.tr(), icon: Icons.settings_outlined),
  ];
  setIndex(int value){
    emit(MainScreenInitial());
    selectedScreen = value;
    emit(GetInitialIndexState());

  }
  bool barkMode = false;
  int selectedScreen = 0;
  getScreen(int value) {
    final SideMenuState? drawerState = sideMenuKey.currentState;

    selectedScreen = value;
    drawerState!.closeSideMenu();

    emit(ChangeSelectedScreenState());
  }

  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();

  openCloseDrawer() {
    emit(MainScreenInitial());

    final SideMenuState? drawerState = sideMenuKey.currentState;

    if (drawerState!.isOpened) {
      drawerState.closeSideMenu();
    } else {
      drawerState.openSideMenu();
    }
    emit(OpenCloseDrawerState());
  }
}
