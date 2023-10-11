import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/app_string.dart';
 
class EmptyItem extends StatelessWidget {
  final Size size;
  final String text;
  const EmptyItem({Key? key, required this.size, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
            fontFamily: "todo",
            color:Theme.of(context).brightness.index==1? AppColor.mainColor2:Colors.white,
            fontWeight: FontWeight.w900,
            fontSize:  context.locale.toString() == AppString.arabic?size.shortestSide * .075:size.shortestSide * .1),
      ),
    );
  }
}
