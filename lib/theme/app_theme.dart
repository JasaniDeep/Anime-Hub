import 'package:flutter/material.dart';

import '../constants/common_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      // primarySwatch: Colors.blue,
      primaryColor: CommonColors.primaryColor,
      brightness: Brightness.light,
      scaffoldBackgroundColor: CommonColors.screenBGColor,
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        side: BorderSide(color: CommonColors.primaryColor, width: 1),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
        overlayColor: WidgetStatePropertyAll(CommonColors.primaryColor),
      ),
      // textTheme: GoogleFonts.robotoTextTheme().copyWith(),
      dialogTheme: DialogThemeData(backgroundColor: CommonColors.whiteColor),
    );
  }
}
