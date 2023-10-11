import 'package:flutter/material.dart';

class ViewNoteInfo extends StatelessWidget {
  final String head;
  final String content;
  final bool headAlignRnght;
  final Size size;
  const ViewNoteInfo({
    Key? key,
    required this.head,
    required this.size,
    required this.headAlignRnght, required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            head,
            textAlign: headAlignRnght ? TextAlign.right : TextAlign.left,
            style: TextStyle(
              fontFamily: headAlignRnght ? "" : "todo",
              fontSize: size.shortestSide * .07,
              fontWeight: FontWeight.w800,
            ),
          ),
          SelectableText(
            content,
            textAlign: headAlignRnght ? TextAlign.right : TextAlign.left,
            style: TextStyle(
              fontSize: size.shortestSide * .05,
            ),
          ),
        ],
      ),
    );
  }
}
