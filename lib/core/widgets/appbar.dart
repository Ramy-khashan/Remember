import 'package:flutter/material.dart';
 

PreferredSizeWidget appbar(
        {required Size size,
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
      backgroundColor: Theme.of(context).primaryColor,
      title: Align(
        alignment: Alignment.centerRight,
        child: Text(
          head,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "logo",
            fontSize:
                isArabic ? size.shortestSide * .07 : size.shortestSide * .1,
          ),
        ),
      ),
    );
