import 'package:barber_pannel/core/themes/colors.dart';
import 'package:barber_pannel/presentation/widgets/login_widget/google_sign_widget.dart';
import 'package:barber_pannel/presentation/widgets/login_widget/login_form_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/routes/routes.dart';
import '../../../core/utils/constant/constant.dart';

class LotinBottomSection extends StatelessWidget {
  const LotinBottomSection({
    super.key,
    required this.screenWidth,
    required this.screenHight,
  });

  final double screenWidth;
  final double screenHight;

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
                  'Welcome back',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 5),
                Text(
                  '👋',
                  style: TextStyle(fontSize: 28),
                ),
              ],
            ),
            ConstantWidgets.hight10(context),
            Text(
                'Please enter your login information below to access your account'),
            ConstantWidgets.hight10(context),
            LoginForm(screenHight: screenHight, screenWidth: screenWidth),
            Align(
              alignment: Alignment.topCenter,
              child: RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(
                    color: AppPalette.blackClr,
                  ),
                  children: [
                    TextSpan(
                      text: "Register",
                      style: TextStyle(
                        color: AppPalette.blackClr,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = ()  => Navigator.pushNamed(context, AppRoutes.register),
                    ),
                  ],
                ),
              ),
            ),
            ConstantWidgets.hight20(context),
            GoogleSignUp(screenWidth: screenWidth, screenHight: screenHight)
          ],
        ),
      ),
    );
  }
}
