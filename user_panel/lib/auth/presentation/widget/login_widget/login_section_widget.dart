import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_panel/auth/presentation/widget/login_widget/login_form_widget.dart';
import 'package:user_panel/core/routes/routes.dart';
import 'package:user_panel/core/utils/constant/constant.dart';
import '../../../../core/common/custom_googlesignin_widget.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/utils/image/app_images.dart';

class LoginComponents {
  //Login Top section
  static Widget loginTopSection(double screenHeight, double screenWidth) {
    return Container(
    height: screenHeight * 0.28,
    width: screenWidth,
    color: AppPalette.orengeClr,
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
        bottom: 0,left: 0,right: 0,
        child: Image.asset(
          AppImages.loginImageAbove,
           height: screenHeight * 0.275, 
           width:  screenWidth,
           fit: BoxFit.contain,
        ),
        )
      ],
    ),
    );
  }
  //Login Bottom section
  static Widget loginBottomSection(double screenHeight, double screenWidth, GlobalKey<FormState> formKey, BuildContext context){
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight:Radius.circular(30),
        ),
        color: AppPalette.whiteClr
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth *.08, vertical: screenHeight * .03),
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
             mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Welcome back!',
                  style: GoogleFonts.plusJakartaSans(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ConstantWidgets.hight10(context),
           Text( "Please enter your login information below to access your account. Join now.",style: TextStyle(color: AppPalette.greyClr),),
           ConstantWidgets.hight10(context),
           LoginFormWidget(screenHeight: screenHeight, screenWidth: screenWidth, formKey: formKey),
           CustomGooglesigninWidget.goToregister(prefixText: "Don't have an account?", suffixText: ' Register', screenWidth: screenWidth, screenHeight:screenHeight, onTap: ()=> Navigator.pushNamed(context, AppRoutes.registreDetail), context: context),
           CustomGooglesigninWidget.googleSignInModule(screenWidth: screenWidth, screenHeight: screenHeight, context: context)
          ],
        ),
        )
    );
  }
}