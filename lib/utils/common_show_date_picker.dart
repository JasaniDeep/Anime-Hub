import 'package:flutter/material.dart';

import '../constants/common_colors.dart';

commonShowDatePicker(context, {DateTime? selectedDate}) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate ?? DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: CommonColors.primaryColor, // Your primary color
            onPrimary: Colors.white, // Text color on primary color
            surface: Colors.white, // Dialog background color
            onSurface: Colors.black87, // Regular text color
          ),
          dialogTheme: DialogThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                8,
              ), // Rounded corners for dialog
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: CommonColors.primaryColor, // Button text color
            ),
          ),
          datePickerTheme: DatePickerThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                8,
              ), // Rounded corners for picker
            ),
          ),
        ),
        child: child!,
      );
    },
  );
  return picked;
}
