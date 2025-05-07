import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteShapeItem extends StatelessWidget {
  final Function() onDelete;
  final Map<String, dynamic> note;
  const NoteShapeItem({Key? key, required this.note, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
                  fontFamily: "arbic",
                  color: Color(
                      int.parse(note["textColor"].toString().substring(6, 16))),
                  fontSize: 28,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
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
                    fontFamily: "arbic",
                    fontSize: 20),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text.rich(TextSpan(
                  style: TextStyle(
                    fontFamily: "arbic",
                    color: Color(int.parse(
                        note["textColor"].toString().substring(6, 16))),
                  ),
                  children: [
                    TextSpan(text: note['time'].toString()),
                    const WidgetSpan(
                      child: SizedBox(
                        width: 15,
                      ),
                    ),
                    TextSpan(text: note['date'].toString()),
                  ])),
              const Spacer(),
              IconButton(
                  color: Color(
                      int.parse(note["textColor"].toString().substring(6, 16))),
                  iconSize: 30,
                  onPressed: onDelete,
                  icon: Icon(CupertinoIcons.trash, color: Colors.red.shade800))
            ],
          ),
        ],
      ),
    );
  }
}
