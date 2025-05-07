import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constant/app_string.dart';

import '../../controller/add_note_controller.dart';

class ChosseColor extends StatelessWidget {
  const ChosseColor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              BlocProvider.of<AddingNoteController>(context)
                  .showColorPicker(context, false);
            },
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: .3,
                            color: Colors.grey.shade600)
                      ],
                      color: BlocProvider.of<AddingNoteController>(context)
                          .pickerBGColor,
                      shape: BoxShape.circle),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  AppString.bgColor.tr(),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              BlocProvider.of<AddingNoteController>(context).showColorPicker(
                context,
                true,
              );
            },
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: .3,
                            color: Colors.grey.shade600)
                      ],
                      color: BlocProvider.of<AddingNoteController>(context)
                          .pickerTextColor,
                      shape: BoxShape.circle),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  AppString.textColor.tr(),
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
