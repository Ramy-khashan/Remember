import 'package:flutter/cupertino.dart';

class HeadItem extends StatelessWidget {
  final String head;
  final Size size;
  const HeadItem({Key? key, required this.size, required this.head})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 18,
        bottom: 10,
      ),
      child: Text(
        head,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: size.shortestSide * .045,
        ),
      ),
    );
  }
}
