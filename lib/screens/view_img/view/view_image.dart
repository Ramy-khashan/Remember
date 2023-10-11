import 'dart:convert';

import 'package:flutter/material.dart';

class ViewImageScreen extends StatelessWidget {
  final String img;
  final int tag;
  const ViewImageScreen({Key? key, required this.img, required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Hero(
              tag: tag,
              child: Image.memory(
                base64Decode(
                  img,
                ),
                fit: BoxFit.fill,
                width: size.width - 30,
                height: size.height / 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
