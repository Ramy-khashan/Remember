import 'package:flutter/material.dart';

import '../constant/app_color.dart';

PreferredSizeWidget appbar(
        { 
        required String head,
        required bool isArabic,
        Widget? leading,
        VoidCallback? onFilter,
        isFillter = false,
        context,
        changeTheme = true}) =>
    AppBar(
      leading: leading ??
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
      // backgroundColor: Theme.of(context).primaryColor,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: Theme.of(context).brightness == Brightness.dark
                    ? [
                        const Color.fromARGB(255, 130, 118, 104),
                        AppColor.mainColor2,
                        Colors.black,
                      ]
                    : [
                        AppColor.mainColor2,
                        const Color.fromARGB(255, 130, 118, 104),
                        Colors.white
                      ])),
      ),
      elevation: 0,
      title: Align(
        alignment: Alignment.centerRight,
        child: Text(
          head,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "logo",
            fontSize:
                35,
          ),
        ),
      ),
    );
