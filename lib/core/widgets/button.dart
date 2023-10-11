import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/app_string.dart';

class ButtonItem extends StatelessWidget {
  final VoidCallback onTap;
  final String head;
  final double textSize;
  final Size size;
  const ButtonItem(
      {Key? key,
      required this.onTap,
      required this.head,
      this.textSize = .05,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: size.shortestSide * .03,
            vertical: size.longestSide * .03),
        padding: EdgeInsets.symmetric(
            vertical: size.longestSide * .01,
            horizontal: size.shortestSide * .025),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            // gradient: RadialGradient(
            //   colors: [
            //     Theme.of(context).primaryColor,
            //     Theme.of(context).cardColor,
            //     Theme.of(context).cardColor,
            //     Theme.of(context).primaryColor,
            //   ],
            // ),
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                spreadRadius: 3,
                color: Colors.grey.withOpacity(.5),
              )
            ]),
        child: Text(
          head,
          style: TextStyle(
            fontFamily: "logo",
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize:context.locale.toString() == AppString.arabic? size.shortestSide * (textSize*5/6):size.shortestSide * textSize,
          ),
        ),
      ),
    );
  }
}
