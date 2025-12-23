import 'package:flutter/material.dart';

import 'common_colors.dart';

Text regularText(
  String text, {
  double? fontsize,
  Color? color,
  bool? center = false,
}) {
  return Text(
    text,
    textAlign: center == true ? TextAlign.center : TextAlign.start,
    style: regularTextStyle(fontsize: fontsize, color: color),
  );
}

Text mediumText(
  String text, {
  double? fontsize,
  Color? color,
  TextAlign? textAlign,
}) {
  return Text(
    text,
    textAlign: textAlign,
    style: mediumTextStyle(fontsize: fontsize, color: color),
  );
}

Text semiBoldText(String text, {double? fontsize, Color? color}) {
  return Text(
    text,
    style: semiBoldTextStyle(fontsize: fontsize, color: color),
  );
}

Text boldText(String text, {double? fontsize, Color? color}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: boldTextStyle(fontsize: fontsize, color: color),
  );
}

TextStyle regularTextStyle({double? fontsize, Color? color}) {
  return TextStyle(
    fontSize: fontsize ?? 14,
    fontWeight: FontWeight.normal,
    color: color ?? CommonColors.blackColor,
  );
}

TextStyle mediumTextStyle({double? fontsize, Color? color}) {
  return TextStyle(
    fontSize: fontsize ?? 14,
    fontWeight: FontWeight.w500,
    color: color ?? CommonColors.blackColor,
  );
}

TextStyle semiBoldTextStyle({double? fontsize, Color? color}) {
  return TextStyle(
    fontSize: fontsize ?? 14,
    fontWeight: FontWeight.w600,
    color: color ?? CommonColors.blackColor,
  );
}

TextStyle boldTextStyle({double? fontsize, Color? color}) {
  return TextStyle(
    fontSize: fontsize ?? 14,
    fontWeight: FontWeight.bold,
    color: color ?? CommonColors.blackColor,
  );
}
