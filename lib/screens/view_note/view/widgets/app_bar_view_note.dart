import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/app_string.dart';

PreferredSizeWidget appBar({
  required BuildContext context,
  required Size size,
  required bool isArabic,
  required Function() onTapEdit}) =>
    AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            AppString.viewNote.tr(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "logo",
                        fontSize:isArabic?  size.shortestSide * .07: size.shortestSide * .1,

            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed:onTapEdit,
              icon: const Icon(Icons.edit))
        ]);
