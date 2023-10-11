import 'dart:convert';

import 'package:flutter/material.dart';

class ImageViewShape extends StatelessWidget {
  final Size size;
  final String img;
  final bool isImg;
  final bool isWithDelete;
  final Function()? onDelete;
  const ImageViewShape(
      {Key? key,
      required this.size,
      required this.img,
      this.isImg = true,
      this.onDelete,
      this.isWithDelete = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, bottom: 10),
      width: size.width * .3,
      height: size.height * .17,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 8,
              spreadRadius: 1,
              color: Theme.of(context).brightness.index == 0
                  ? Colors.black.withOpacity(.3)
                  : Colors.black.withOpacity(.12))
        ],
        borderRadius: BorderRadius.circular(13),
        color: Theme.of(context).brightness.index == 0
            ? Colors.grey.withOpacity(.3)
            : Colors.grey.shade200,
        border: Border.all(
          color:Theme.of(context).brightness.index == 0
            ? Colors.grey.shade700.withOpacity(.7):Colors.grey.shade700.withOpacity(.2),
        ),
      ),
      child: isImg
          ? Stack(
              children: [
                Image.memory(
                  base64Decode(
                    img,
                  ),
                  fit: BoxFit.fill,
                  width: size.width * .3,
                  height: size.height * .17,
                ),
                isWithDelete
                    ? Positioned(
                        right: 0,
                        child: IconButton(
                          onPressed: onDelete,
                          icon: Icon(
                            Icons.delete,
                            size: size.shortestSide * .08,
                            color: Colors.red.shade600,
                            shadows: const [
                              Shadow(
                                blurRadius: 3,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            )
          : Icon(
              Icons.add,
              size: size.shortestSide * .08,
            ),
    );
  }
}
