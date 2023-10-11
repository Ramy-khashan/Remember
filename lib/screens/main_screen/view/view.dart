import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/app_string.dart';
import '../../ring.dart';
import '../controller/main_screen_cubit.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../../../core/widgets/appbar.dart';

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
     subscription ??= Alarm.ringStream.stream.listen(
      (alarmSettings) => 
       Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              TaskDeadLineScreen(alarmSettings: alarmSettings),
        )) 
     
    );
  }
    @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) =>
          MainScreenCubit()..setIndex( widget.initialIndex ?? 0),
      child: BlocBuilder<MainScreenCubit, MainScreenState>(
        builder: (context, state) {
          final controller = MainScreenCubit.get(context);
          return Container(
            decoration: BoxDecoration(
              // image: DecorationImage(image:AssetImage("assets/images/img.jpeg"),fit: BoxFit.fill)
              gradient: LinearGradient(colors: [
                const Color.fromARGB(255, 32, 129, 159).withOpacity(.6),
                const Color.fromARGB(255, 17, 74, 92).withOpacity(.7),
                const Color(0xff570f25),
                const Color.fromARGB(255, 185, 12, 64).withOpacity(.6),
              ], begin: Alignment.centerLeft, end: Alignment.centerRight),
            ),
            child: SideMenu(
              background: Colors.transparent,
              key: controller.sideMenuKey,
              menu: Padding(
                padding: EdgeInsets.only(top: size.longestSide * .1),
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
                                      size: size.longestSide * .045,
                                    ),
                                    title: Text(
                                      controller.screenTitle[index].title,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: size.shortestSide * .047,
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
                      size: size,
                      context: context),
                  // drawer: Drawer(
                  //     child: Column(
                  //   children: List.generate(
                  //       controller.screenTitle.length,
                  //       (index) => ListTile(
                  //             leading: Icon(controller.screenTitle[index].icon),
                  //             title: Text(controller.screenTitle[index].title),
                  //             onTap:()=> controller.getScreen(index),
                  //           )),
                  // )),
                  body: controller.screens[controller.selectedScreen]),
            ),
          );
        },
      ),
    );
  }
}
