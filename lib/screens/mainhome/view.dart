import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remember/constant.dart';
import 'controller.dart';
import 'state.dart';

class MainHome extends StatelessWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => MainHomeController(),
      child: BlocBuilder<MainHomeController, MainHomeStates>(
        builder: (context, state) {
          final controller = MainHomeController.get(context);
          return Scaffold(
            body: controller.pages[controller.index],
            bottomNavigationBar: BottomNavigationBar(
                onTap: (val) => controller.changeIndecator(val),
                currentIndex: controller.index,
                items: const [
                  BottomNavigationBarItem(
                    label: "Note",
                    icon: Icon(Icons.note),
                  ),
                  BottomNavigationBarItem(
                      label: "Todo",
                      icon: Icon(
                        Icons.task,
                      )),
                ],
                backgroundColor: Theme.of(context).brightness.index == 0
                    ? mainColor1
                    : Colors.white,
                elevation: 10,
                unselectedItemColor: Theme.of(context).brightness.index == 0
                    ? Colors.white
                    : Colors.grey[400],
                unselectedFontSize: size.shortestSide * .03,
                selectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: size.shortestSide * .045,
                  fontFamily: "logo",
                ),
                unselectedLabelStyle: TextStyle(
                  fontFamily: "logo",
                  fontSize: size.shortestSide * .04,
                ),
                selectedIconTheme: IconThemeData(size: size.shortestSide * .08),
                selectedItemColor:mainColor2),
          );
        },
      ),
    );
  }
}
