import 'package:flutter/material.dart';

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
      child: Icon(
        icon,
        size: size,
      ),
    );
  }
}
