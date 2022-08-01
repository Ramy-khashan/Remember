import 'package:flutter/material.dart';

class EmptyItem extends StatelessWidget {
  final Size size;
  final String text;
  const EmptyItem({Key? key, required this.size, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
            fontFamily: "todo",
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w900,
            fontSize: size.shortestSide * .1),
      ),
    );
  }
}
