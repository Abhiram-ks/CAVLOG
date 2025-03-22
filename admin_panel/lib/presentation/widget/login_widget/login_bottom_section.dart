import 'package:admin/presentation/widget/login_widget/login_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/themes/colors.dart';
import '../../../core/utils/media_quary/constant/constant.dart';

class LoginBottomSection extends StatelessWidget {
  final double screenHight;
  final double screenWidth;
  final GlobalKey<FormState> formKey;

  const LoginBottomSection({super.key,required this.screenHight, required this.screenWidth, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.08, vertical: screenHight * 0.03),
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
            ConstantWidgets.hight20(context),
            LoginForm(screenHight: screenHight, screenWidth: screenWidth,formKey: formKey,),
          ],
        ),
      ),
    );
  }
}