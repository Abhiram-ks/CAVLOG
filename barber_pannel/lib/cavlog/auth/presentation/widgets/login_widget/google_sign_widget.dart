
import 'package:flutter/material.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/utils/image/app_images.dart';

class GoogleSignUp extends StatelessWidget {
  final double screenWidth;
  final double screenHight;

  
  const GoogleSignUp({
    super.key,
    required this.screenWidth,
    required this.screenHight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenHight * 0.062,
      decoration: BoxDecoration(
          color: AppPalette.trasprentClr,
          border: Border.all(color: AppPalette.hintClr, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          splashColor: AppPalette.hintClr.withAlpha(100),
          borderRadius:
              BorderRadius.circular(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.googleImage,
                height: screenHight * 0.056,
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
