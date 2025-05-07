import 'package:flutter/material.dart';


class ButtonItem extends StatelessWidget {
  final VoidCallback onTap;
  final double textSize;
  final String head;
    const ButtonItem(
      {Key? key,
      required this.onTap,
      required this.head,
        this.textSize=28,
   
 })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical:6),
        padding: const EdgeInsets.symmetric(
            vertical:4,
            horizontal: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                spreadRadius: 2,
                color: Colors.grey.withOpacity(.5),
              )
            ]),
        child: Text(
          head,
          style:   TextStyle(
            fontFamily: "logo",
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize:textSize,
          ),
        ),
      ),
    );
  }
}
