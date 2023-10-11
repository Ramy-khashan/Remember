import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../utils/app_color.dart';

class TodoShapeItem extends StatelessWidget {
  final Map<String, dynamic> todo;
  final Size size;
  final Function(bool val) onChanged;
  const TodoShapeItem(
      {Key? key,
      required this.todo,
      required this.size,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) { 
    return Container(
      decoration: BoxDecoration(
          boxShadow: todo["isDone"] == 0
              ? const [
                  BoxShadow(blurRadius: 5, color: Colors.grey, spreadRadius: 3)
                ]
              : [],
          color: todo["isDone"] == 0 ? Colors.white : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(
        horizontal: size.shortestSide * .02,
        vertical: size.longestSide * .015,
      ),
      padding: EdgeInsets.symmetric(
          vertical: size.longestSide * .01,
          horizontal: size.shortestSide * .04),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                todo["head"].toString(),
                textAlign:
                    todo["type"] == "ar" ? TextAlign.right : TextAlign.left,
                style: TextStyle(
                    fontFamily: todo['type'] == "ar" ? "" : "todo",
                    decoration: todo["isDone"] == 0
                        ? TextDecoration.none
                        : TextDecoration.lineThrough,
                    color: todo["isDone"] == 0 ? Colors.black : Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: size.shortestSide * .056),
              ),
            ),
            Row(
              textDirection:
                  todo["type"] == "ar" ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Text.rich(TextSpan(
                    style: const TextStyle(
                        fontFamily: "todo", color: AppColor.mainColor2),
                    children: [
                      TextSpan(text: todo['time'].toString()),
                      WidgetSpan(
                        child: SizedBox(
                          width: size.shortestSide * .03,
                        ),
                      ),
                      TextSpan(text: todo['date'].toString())
                    ])),
                const Spacer(),
                Checkbox(
                    hoverColor: Colors.transparent,
                    fillColor: MaterialStateProperty.all(AppColor.mainColor2),
                    value: todo["isDone"] == 0 ? false : true,
                    onChanged: (val) {
                      onChanged(val!);
                    }),
              ],
            ),
            todo["isDone"] == 0
                ? todo["deadLine"] ==
                        DateTime.now().toLocal().toString().substring(0, 10)
                    ? Column(children: [
                        const Divider(
                          color: Colors.black,
                        ),
                        intl.DateFormat.jm()
                                    .parse(todo["endTime"].toString().replaceAll("م", "PM").replaceAll("ص", "AM"))
                                    .difference(intl.DateFormat.jm().parse(
                                        intl.DateFormat.jm()
                                            .format(DateTime.now())))
                                    .inMinutes <=
                                0
                            ? const Text.rich(TextSpan(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis),
                                children: [
                                    TextSpan(text: "This task is out of date "),
                                    TextSpan(
                                      text: "( Expired ) ",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis),
                                    )
                                  ]))
                            : 
                            Text.rich(TextSpan(
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis),
                                children: [
                                    const TextSpan(text: "Today  "),
                                    TextSpan(
                                        text: todo["deadLine"],
                                        style: TextStyle(
                                            color: Colors.red.shade900,
                                            fontWeight: FontWeight.bold)),
                                    const TextSpan(
                                        text: "  Deadline of this task at  "),
                                    TextSpan(
                                        text: todo["endTime"],
                                        style: TextStyle(
                                            color: Colors.red.shade900,
                                            fontWeight: FontWeight.bold)),
                                  ]))
                      ])
                    : const SizedBox.shrink()
                : const SizedBox.shrink()
          ]),
    );
  }
}
