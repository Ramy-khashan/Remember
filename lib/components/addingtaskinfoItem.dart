import 'package:flutter/material.dart';
import 'package:remember/components/head.dart';
import 'package:remember/constant.dart';

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
            padding: const EdgeInsets.only(left: 12),
            height: size.longestSide * .075,
            decoration: BoxDecoration(
                color: mainColor1.withOpacity(.15),
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
                    icon: Icon(
                      Icons.access_time,
                      color: mainColor2,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
