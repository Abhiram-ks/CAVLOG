import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../utils/constant/constant.dart';
import '../utils/image/app_images.dart';

class CustomGooglesigninWidget {
  static Widget goToregister({
    required String prefixText,
    required String suffixText,
    required double screenWidth,
    required double screenHeight,
    required VoidCallback onTap,
    required BuildContext context
  }){
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
   
   static Widget googleSignInModule({
    required double screenWidth,
    required double screenHeight,
    required BuildContext context
  }){
    return Container(
      width: screenWidth,
      height: screenHeight * 0.062,
      decoration: BoxDecoration(
          color: AppPalette.trasprentClr,
          border: Border.all(color: AppPalette.hintClr, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (){},
          splashColor: AppPalette.hintClr.withAlpha(100),
          borderRadius:
              BorderRadius.circular(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.googleImage,
                height: screenHeight * 0.056,
                fit: BoxFit.fill,
              ),
              Text(
                "  Sign Up with Google",
                style: TextStyle(
                  fontSize: 16,
                  color: AppPalette.blackClr,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}