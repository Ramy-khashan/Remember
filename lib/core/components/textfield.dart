import 'package:flutter/material.dart';

class TextFieldItem extends StatelessWidget {
  final String lable;
  final TextEditingController controller;
  final int lines;
  final bool isNeedBorder;
  final String valid;
  final String lan;
  final Function(String val) onChange;
  const TextFieldItem(
      {Key? key,
      required this.onChange,
      this.valid = "",
      this.lan = "en",
      required this.controller,
      required this.lable,
      this.lines = 1,
      this.isNeedBorder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (val) {
        onChange(val);
      },
      validator: (value) {
        if (value!.isEmpty) {
          return valid;
        }
        return null;
      },
      textAlign: lan == "ar" ? TextAlign.right : TextAlign.left,
      controller: controller,
      maxLines: lines,
      keyboardType: TextInputType.multiline,
      autofocus: true,
      decoration: InputDecoration(
          hintText: lable,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          enabledBorder: isNeedBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ))
              : const OutlineInputBorder(borderSide: BorderSide.none),
          disabledBorder: isNeedBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300))
              : const OutlineInputBorder(borderSide: BorderSide.none),
          border: isNeedBorder
              ? OutlineInputBorder(borderRadius: BorderRadius.circular(12))
              : const OutlineInputBorder(borderSide: BorderSide.none)),
    );
  }
}
