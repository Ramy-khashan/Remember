import 'package:flutter/material.dart';

class NoteShapeItem extends StatelessWidget {
  final Function() onDelete;
  final Size size;
  final Map<String, dynamic> note;
  const NoteShapeItem(
      {Key? key,
      required this.size,
      required this.note,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: size.shortestSide * .03,
          vertical: size.longestSide * .015),
      padding: EdgeInsets.symmetric(
          horizontal: size.shortestSide * .03,
          vertical: size.longestSide * .01),
      decoration: BoxDecoration(
          color: Color(int.parse(note["bgColor"].toString().substring(6, 16))),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 6, spreadRadius: 1)
          ],
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              note['title'].toString(),
              textAlign:
                  note["titleType"] == "ar" ? TextAlign.right : TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontFamily: note['titleType'] == "ar" ? "" : "todo",
                  color: Color(
                      int.parse(note["textColor"].toString().substring(6, 16))),
                  fontSize: size.shortestSide * .06,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                note['note'].toString(),
                textAlign:
                    note["noteType"] == "ar" ? TextAlign.right : TextAlign.left,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color(int.parse(
                        note["textColor"].toString().substring(6, 16))),
                    fontFamily: note['noteType'] == "ar" ? "" : "todo",
                    fontSize: size.shortestSide * .045),
              ),
            ),
          ),
          Row(
            children: [
              Text.rich(TextSpan(
                  style: TextStyle(
                    fontFamily: "todo",
                    color: Color(int.parse(
                        note["textColor"].toString().substring(6, 16))),
                  ),
                  children: [
                    TextSpan(text: note['time'].toString()),
                    WidgetSpan(
                      child: SizedBox(
                        width: size.shortestSide * .03,
                      ),
                    ),
                    TextSpan(text: note['date'].toString()),
                  ])),
              const Spacer(),
              IconButton(
                  color: Color(
                      int.parse(note["textColor"].toString().substring(6, 16))),
                  iconSize: size.shortestSide * .08,
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete))
            ],
          ),
        ],
      ),
    );
  }
}
