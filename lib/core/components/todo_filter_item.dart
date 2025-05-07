import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../constant/app_string.dart';
import 'button.dart';

class TodoFilterItem extends StatelessWidget {
  final String head;
  final Function() onTap;
  const TodoFilterItem({
    Key? key,
    required this.head,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            head,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness.index == 0
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          const Spacer(),
          ButtonItem(onTap: onTap, head: AppString.show.tr(), textSize: 23)
        ],
      ),
    );
  }
}
