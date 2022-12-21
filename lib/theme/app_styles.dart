import 'package:flutter/material.dart';
import 'package:reading_tracker/theme/pallete.dart';

class AppStyles {
  static const TextStyle headingOne = TextStyle(
      fontSize: 40, fontWeight: FontWeight.bold, color: Pallete.primaryBlue);

  static const TextStyle headingTwo = TextStyle(
      fontSize: 36, fontWeight: FontWeight.w500, color: Pallete.primaryBlue);

  static const TextStyle headingThree = TextStyle(
      fontSize: 32, fontWeight: FontWeight.w500, color: Pallete.primaryBlue);

  static const TextStyle headingFour = TextStyle(
      fontSize: 24, fontWeight: FontWeight.w500, color: Pallete.primaryBlue);

  static const TextStyle subheading = TextStyle(
      fontSize: 24, fontWeight: FontWeight.w500, color: Pallete.textBlue);

  static const TextStyle subtext =
      TextStyle(fontSize: 18, color: Pallete.textGrey);

  static const TextStyle highlightedSubtext =
      TextStyle(fontSize: 18, color: Pallete.textBlue);

  static const TextStyle bodyText = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, color: Pallete.textGrey);
}
