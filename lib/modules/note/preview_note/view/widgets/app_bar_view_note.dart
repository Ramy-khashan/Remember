import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constant/app_string.dart';

PreferredSizeWidget appBar({
  required BuildContext context,
   required bool isArabic,
  required Function() onTapEdit}) =>
    AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            AppString.viewNote.tr(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "logo",
                        fontSize:35,

            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed:onTapEdit,
              icon: const Icon(Icons.edit))
        ]);
