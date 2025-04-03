import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_panel/auth/presentation/widget/otp_widget/otp_widget.dart';
import 'package:user_panel/core/common/custom_appbar_widget.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utils/constant/constant.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
       double screenHeight = constraints.maxHeight;
       double screenWidth = constraints.maxWidth;

       return Scaffold(
        appBar: const CustomAppBar(),
        body: SafeArea(
          child: GestureDetector(
           onTap: () => FocusScope.of(context).unfocus(),
           child: SingleChildScrollView(
             keyboardDismissBehavior:ScrollViewKeyboardDismissBehavior.onDrag,
            physics: BouncingScrollPhysics(),
            child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.08,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Authentication', style: GoogleFonts.plusJakartaSans(fontSize: 28, fontWeight: FontWeight.bold)),
                ConstantWidgets.hight10(context),
                Text( 'Almost there! Please check your email and enter the authentication code we have sent to your email  *******@gmail.com'),
                ConstantWidgets.hight10(context),
                Text("OTP will expire in 2 minutes.", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w100, color: AppPalette.greyClr),
                ),
                ConstantWidgets.hight20(context),
                OtpWidget(screenHight: screenHeight, screenWidth: screenWidth)
              ],
            ),
          ),
           ),
          )
        ),
       );
      });
  }
}