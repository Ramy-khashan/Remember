import 'package:flutter/material.dart';

class ViewNoteInfo extends StatelessWidget {
  final String head;
  final String content;
  final bool headAlignRnght;
   const ViewNoteInfo({
    Key? key,
    required this.head,
     required this.headAlignRnght, required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
          SelectableText(
            content,
            textAlign: headAlignRnght ? TextAlign.right : TextAlign.left,
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
