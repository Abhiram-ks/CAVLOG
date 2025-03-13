import 'package:barber_pannel/core/common/action_button_common.dart';
import 'package:barber_pannel/core/common/custom_appbar_common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/constant/constant.dart';
import '../../../core/utils/media_quary/meida_quary_helper.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHight = MeidaQuaryHelper.height(context);
    double screenWidth = MeidaQuaryHelper.width(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(),
      body: SafeArea(
          child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: BouncingScrollPhysics(),
          child: Padding(
           padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.08,
            ),
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Text(
                  'Authentication',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                ConstantWidgets.hight10(context),
                Text( 'Please enter the authentication code that we have sent to your email.'),
               ConstantWidgets.hight10(context),
                Text(
                  'Have not receive code?',
                  style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                
                ),
                TextFormField(),
                ConstantWidgets.hight10(context),
                ActionButton(screenWidth: screenWidth, onTap: (){}, label: 'Send', screenHight: screenHight)
              ],
            ),
          ),
        ),
      )),
    );
  }
}
