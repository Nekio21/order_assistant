import 'package:flutter/material.dart';

class AppTextStyle {
  AppTextStyle._();

  static final TextStyle headingLarge = const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w200,
  );

  static final TextStyle bodyLarge = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle captionRegular = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w200,
  );

  static final TextStyle captionBold = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle captionSmallBold = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle captionSmall = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w200,
  );
}
