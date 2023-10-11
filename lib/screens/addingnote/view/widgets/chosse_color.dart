import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_string.dart';

import '../../controller/add_note_controller.dart';

class ChosseColor extends StatelessWidget {
  final Size size;

  const ChosseColor({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.shortestSide * .03),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              BlocProvider.of<AddingNoteController>(context)
                  .showColorPicker(context, false, size);
            },
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor:
                      BlocProvider.of<AddingNoteController>(context)
                          .pickerBGColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  AppString.bgColor.tr(),
                  style: TextStyle(
                      fontSize: size.shortestSide * .05,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              BlocProvider.of<AddingNoteController>(context)
                  .showColorPicker(context, true, size);
            },
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor:
                      BlocProvider.of<AddingNoteController>(context)
                          .pickerTextColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  AppString.textColor.tr(),
                  style: TextStyle(
                      fontSize: size.shortestSide * .05,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
