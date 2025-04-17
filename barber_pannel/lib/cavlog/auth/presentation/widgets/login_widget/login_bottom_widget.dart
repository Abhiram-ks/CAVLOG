import 'package:barber_pannel/core/themes/colors.dart';
import 'package:barber_pannel/cavlog/auth/presentation/widgets/login_widget/login_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/common/google_singin_common.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/utils/constant/constant.dart';

class LotinBottomSection extends StatelessWidget {
  const LotinBottomSection({
    super.key,
    required this.screenWidth,
    required this.screenHight,
    required this.formKey,
  });

  final double screenWidth;
  final double screenHight;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: AppPalette.scafoldClr,
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
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ConstantWidgets.hight10(context),
            Text( "Please enter your login information below to access your account. Join now.",style: TextStyle(color: AppPalette.greyClr),),
            ConstantWidgets.hight10(context),
            LoginForm(screenHight: screenHight, screenWidth: screenWidth,formKey: formKey,),
            GoogleSignInModule(
              screenWidth: screenWidth,
              screenHight: screenHight,
              prefixText: "Don't have an account?",
              suffixText: " Register",
              onTap: () =>Navigator.pushNamed(context, AppRoutes.registerDetails),
            )
          ],
        ),
      ),
    );
  }
}
