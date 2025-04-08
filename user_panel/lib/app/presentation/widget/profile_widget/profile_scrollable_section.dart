import 'package:flutter/material.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/utils/constant/constant.dart';

SizedBox profileviewWidget(double screenWidth, BuildContext context,
      IconData icons, String heading, Color iconclr, {Color? textColor}) {
    return SizedBox(
      width: screenWidth * 0.55,
      child: Row(children: [
        Icon(
          icons,
          color: iconclr,
        ),
        ConstantWidgets.width20(context),
        Expanded(
          child: Text(
            heading,
            style: TextStyle(
              color: textColor ?? AppPalette.whiteClr,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ]),
    );
  }