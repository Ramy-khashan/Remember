import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application/core/constant/app_color.dart';
import '../../../core/constant/app_string.dart';
import '../../../core/components/ring.dart';
import '../controller/main_screen_cubit.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../../../core/components/appbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, this.initialIndex}) : super(key: key);
  final int? initialIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    subscription ??=
        Alarm.ringStream.stream.listen((alarmSettings) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TaskDeadLineScreen(alarmSettings: alarmSettings),
            )));
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MainScreenCubit()..setIndex(widget.initialIndex ?? 0),
      child: BlocBuilder<MainScreenCubit, MainScreenState>(
        builder: (context, state) {
          final controller = MainScreenCubit.get(context);
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                AppColor.mainColor2,
                Color(0xffac9c88),
              ], begin: Alignment.centerLeft, end: Alignment.centerRight),
            ),
            child: SideMenu(
              background: Colors.transparent,
              key: controller.sideMenuKey,
              menu: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Column(
                      children: List.generate(
                          controller.screenTitle.length,
                          (index) => Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: controller.selectedScreen == index
                                      ? Colors.grey.shade100.withOpacity(.2)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: GestureDetector(
                                  onTap: () => controller.getScreen(index),
                                  child: ListTile(
                                    leading: Icon(
                                      controller.screenTitle[index].icon,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                    title: Text(
                                      controller.screenTitle[index].title,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: "arbic",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  ],
                ),
              ),
              inverse:
                  context.locale.toString() == AppString.arabic ? true : false,
              type: SideMenuType.shrinkNSlide,
              child: Scaffold(
                  appBar: appbar(
                      isArabic: context.locale.toString() == AppString.arabic,
                      leading: IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          controller.openCloseDrawer();
                        },
                      ),
                      head: controller
                          .screenTitle[controller.selectedScreen].title,
                      context: context),
                  body: controller.screens[controller.selectedScreen]),
            ),
          );
        },
      ),
    );
  }
}
