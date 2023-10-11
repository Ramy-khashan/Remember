import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/app_string.dart';
import 'head.dart';

class StartEndTimeItem extends StatelessWidget {
  final String head;
  final String time;
  final Size size;
  final VoidCallback onTap;

  const StartEndTimeItem(
      {Key? key,
      required this.head,
      required this.time,
      required this.onTap,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadItem(size: size, head: head),
          Container(
            padding: EdgeInsets.only(
                left: context.locale.toString() == AppString.arabic ? 0 : 12,
                right: context.locale.toString() == AppString.arabic ? 12 : 0),
            height: size.longestSide * .075,
            decoration: BoxDecoration(
                color: AppColor.mainColor1.withOpacity(.15),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Text(
                  time,
                  style: Theme.of(context).textTheme.headline6,
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
