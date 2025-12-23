import 'dart:math';

import 'package:flutter/material.dart';

class CommonColors {
  static Color transparentColor = Colors.transparent;
  static Color whiteColor = Colors.white;
  static Color blackColor = Colors.black;

  static Color primaryColor = const Color(0xFFE97120);
  static const Color subtitleGreyColor = Color(0xFF5C5C5C);
  static const Color fillColor = Color(0xFFf5f6f8);
  static const Color prefixColor = Color(0xFF626262);
  static const Color secondary = Color(0xFF575757);
  static const Color textColor = Color(0xFF7E7E7E);
  static const Color borderColor = Color(0xFFD8DADC);
  static const Color borderColor2 = Color(0xFFEDEDED);
  static const Color greyTextColor = Color(0xFF9CA3AF);
  static const Color onboardingDotColor = Color(0xFF17223B);
  static const Color screenBGColor = Color(0xFFF6F6F6);
  static const Color wardrobeBtnBgColor = Color(0xFFF3764F);
  static const Color btnTextColor = Color(0xFF484848);
  static const Color btnBgColor = Color(0xFFD9D9D9);
  static const Color categoryTileBgColor = Color(0xFFF1F1F1);
  static const Color searchBarHintTextColor = Color(0xFF7B7B7B);
  static const Color selectionChipBgColor = Color(0xFFEAEAEA);
  static const Color selectionChipDisabledTextColor = Color(0xFF676767);
  static const Color socialMediaTextColor = Color(0xFF343434);
  static const Color expandableTileTitleTextColor = Color(0xFF5B5B5B);
  static const Color expandableTileContentTextColor = Color(0xFF888888);
  static const Color expandableTilePlusMinusIconColor = Color(0xFF888888);

  static const Color redColor = Color(0xFFE30E0D);

  // static Color grey600 = Colors.grey[600]!;
}

final random = Random();
Color randomColorReturn({int? index}) {
  List<Color> co = [CommonColors.redColor, CommonColors.primaryColor];

  // Create Random instance

  // Get random index between 0 and list length-1
  return co[index ?? random.nextInt(co.length)];
}
