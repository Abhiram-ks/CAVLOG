
import 'package:barber_pannel/core/common/custom_app_bar.dart';
import 'package:barber_pannel/core/common/textfield_helper.dart';
import 'package:barber_pannel/core/utils/media_quary/constant/constant.dart';
import 'package:barber_pannel/core/utils/media_quary/meida_quary_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHight = MeidaQuaryHelper.height(context);
    double screenWidth = MeidaQuaryHelper.width(context);
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: BouncingScrollPhysics(),
            child: Padding(
               padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08,
                  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Forgot password?',
                        style: GoogleFonts.plusJakartaSans( fontSize: 28, fontWeight: FontWeight.bold),
                      ), ConstantWidgets.hight10(context),
                    Text("Enter your registered email address to receive a password reset link. Make sure to check your email for further instructions."),
                    ConstantWidgets.hight20(context),
                    TextFormFieldWidget(label: 'Email', hintText: "Enter Email id", prefixIcon: Cupertion, controller: controller, validate: validate)
                ],
              ),
            ),
          ),
        )
        ),
    );
  }
}