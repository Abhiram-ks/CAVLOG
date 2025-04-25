import 'package:flutter/material.dart';
import '../../../../../core/themes/colors.dart';

InkWell serviceTags(
    {required VoidCallback onTap,required String text,required bool isSelected}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: isSelected ? AppPalette.greyClr : AppPalette.whiteClr,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppPalette.greyClr : AppPalette.hintClr,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10, vertical: 5,
      ),
      child: Text(text,
          style: TextStyle(fontSize: 18,color: isSelected ? AppPalette.whiteClr : AppPalette.greyClr)),
    ),
  );
}
