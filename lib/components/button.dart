import 'package:flutter/material.dart';

class ButtonItem extends StatelessWidget {
  final VoidCallback onTap;
  final String head;
  final double textSize;
  final Size size;
  const ButtonItem(
      {Key? key,
      required this.onTap,
      required this.head,
      this.textSize = .05,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: size.shortestSide * .03,
            vertical: size.longestSide * .03),
        padding: EdgeInsets.symmetric(
            vertical: size.longestSide * .01,
            horizontal: size.shortestSide * .025),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).cardColor,
                Theme.of(context).cardColor,
                Theme.of(context).primaryColor,
              ],
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                spreadRadius: 3,
                color: Colors.grey.withOpacity(.5),
              )
            ]),
        child: Text(
          head,
          style: TextStyle(
            fontFamily: "logo",
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.w600,
            fontSize: size.shortestSide * textSize,
          ),
        ),
      ),
    );
  }
}
