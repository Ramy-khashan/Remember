import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../constant/app_color.dart';
import '../constant/app_string.dart';
import 'head.dart';

class StartEndTimeItem extends StatelessWidget {
  final String head;
  final String time;
   final VoidCallback onTap;

  const StartEndTimeItem(
      {Key? key,
      required this.head,
      required this.time,
      required this.onTap,
     })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadItem(  head: head),
          Container(
            padding: EdgeInsets.only(
                left: context.locale.toString() == AppString.arabic ? 0 : 12,
                right: context.locale.toString() == AppString.arabic ? 12 : 0),
            height: 40,
            decoration: BoxDecoration(
                color: AppColor.mainColor1.withOpacity(.15),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Text(
                  time,
                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 22),
                ),
                const Spacer(),
                IconButton(
                    onPressed: onTap,
                    icon: const Icon(
                      Icons.access_time,
                      color: AppColor.mainColor2,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
