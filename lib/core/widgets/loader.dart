import 'package:flutter/material.dart';
import 'package:reading_tracker/theme/pallete.dart';

class Loader extends StatelessWidget {
  final Color color;
  final double strokeWidth;

  const Loader(
      {super.key, this.color = Pallete.primaryBlue, this.strokeWidth = 4.0});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: color, strokeWidth: strokeWidth),
    );
  }
}
