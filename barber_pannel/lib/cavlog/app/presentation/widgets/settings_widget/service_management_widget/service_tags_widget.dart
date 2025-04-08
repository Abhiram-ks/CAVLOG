

import 'package:barber_pannel/core/themes/colors.dart';
import 'package:flutter/material.dart';

InkWell serviceTags(
    {required VoidCallback onTap,
    required String text,
    required bool isSelected}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: isSelected ? AppPalette.orengeClr : AppPalette.whiteClr,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppPalette.orengeClr,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 18,
              color: isSelected ? AppPalette.whiteClr : AppPalette.orengeClr)),
    ),
  );
}
