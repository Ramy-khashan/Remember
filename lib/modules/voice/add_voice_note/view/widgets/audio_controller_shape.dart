import 'package:flutter/material.dart';
import 'package:test_application/core/constant/app_color.dart';

class RecordControlleshape extends StatelessWidget {
  const RecordControlleshape(
      {super.key, required this.icon, required this.size, required this.onTap, required this.heroTag});
  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final String heroTag;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag:heroTag,
     shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0)),
      onPressed: onTap,
      backgroundColor: Colors.white,
      
      child: Icon(
        icon,
        size: size,
        color:AppColor.mainColor2
      ),
    );
  }
}
