
import 'package:barber_pannel/core/utils/constant/constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../themes/colors.dart';

class GoogleSignInModule extends StatelessWidget {
  final String prefixText;
  final String suffixText;
  final double screenWidth;
  final double screenHight;
  final VoidCallback onTap;

  const GoogleSignInModule({
    super.key,
    required this.screenWidth,
    required this.screenHight, required this.prefixText, required this.suffixText, required this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  thickness: 0.9,
                  color: AppPalette.hintClr,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Or",
                ),
              ),
              Expanded(
                child: Divider(
                  thickness: 0.9,
                  color: AppPalette.hintClr,
                ),
              ),
            ],
          ),
        ),
        ConstantWidgets.hight20(context),
        Align(
          alignment: Alignment.topCenter,
          child: RichText(
            text: TextSpan(
              text: prefixText,
              style: TextStyle(
                color: AppPalette.blackClr,
              ),
              children: [
                TextSpan(
                  text: suffixText,
                  style: TextStyle(
                    color: AppPalette.blackClr,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = onTap
                ),
              ],
            ),
          ),
        ),
        ConstantWidgets.hight20(context),
      ],
    );
  }
}
