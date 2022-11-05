import 'package:flutter/material.dart';
import 'package:reading_tracker/theme/Pallete.dart';

class Loader extends StatelessWidget {
  final Color color;
  final double strokeWidth;

  const Loader(
      {super.key, this.color = Pallete.primaryBlue, this.strokeWidth = 4.0});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            CircularProgressIndicator(color: color, strokeWidth: strokeWidth),
      ),
    );
  }
}
