import 'package:flutter/material.dart';
import '../../../core/themes/colors.dart';
import '../../../core/utils/images/app_images.dart';

class LoginTopSection extends StatelessWidget {
  final double screenHight;
  final double screenWidth;

  const LoginTopSection({super.key, required this.screenHight, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(height: screenHight * 0.28,
    width: screenWidth,
    color: AppPalette.mainClr,
    child: Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.hardEdge,
      children: [
        Positioned.fill(
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(AppPalette.greyClr.withAlpha((0.19* 255).toInt()),  BlendMode.modulate,),
            child: Image.asset(
            AppImages.loginImageBelow,fit: BoxFit.cover,
            ),
          ),
          ),
       Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Image.asset(
          AppImages.loginImageAbove,
           height: screenHight * 0.275, 
           width:  screenWidth,
           fit: BoxFit.contain,
        ),
        )
      ],
    ),
    );
  }
}

