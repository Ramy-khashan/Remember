 

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../constant/app_string.dart';
import '../constant/app_color.dart';
import 'head.dart';

class DropDownListItem extends StatelessWidget {
  final String reminderValue;
  final String head;
   final List<String> listType;
  final List<String> listTypeAr;
  final Function(dynamic value) onChange;
  const DropDownListItem(
      {Key? key,
      required this.onChange,
      required this.listType,
      required this.reminderValue,
      required this.listTypeAr,
      required this.head,
 })
      : super(key: key);

  @override
  Widget build(BuildContext context) { 
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadItem(
          head: head,
         ),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: AppColor.mainColor1.withOpacity(.15),
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(12),
              isExpanded: true,
              underline: Container(color: Colors.transparent),
              value: reminderValue,
              icon: const Icon(
                Icons.keyboard_arrow_down_outlined,
                color: AppColor.mainColor2,
              ),
              style: Theme.of(context).textTheme.headlineLarge,
              onChanged: onChange,
              items: listType.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(context.locale.toString() != AppString.arabic
                      ? value
                      : value.toString() == listType[0]
                          ? listTypeAr[0]
                          : value.toString() == listType[1]
                              ? listTypeAr[1]
                              : value.toString() == listType[2]
                                  ? listTypeAr[2]
                                  : listTypeAr[3],),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
