import 'package:barber_pannel/core/common/custom_appbar_common.dart';
import 'package:barber_pannel/core/common/textfiled_phone_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/common/textfiled_common.dart';
import '../../../core/utils/constant/constant.dart';
import '../../../core/utils/media_quary/meida_quary_helper.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Register here',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    ConstantWidgets.hight10(context),
                    Text('Please enter your data to complete your account registration process.'),
                    ConstantWidgets.hight20(context),
                    TextFormFieldWidget(
                      label: 'Full Name',
                      hintText: 'Authorized Person Name',
                      prefixIcon: CupertinoIcons.person_fill,
                    ),
                    TextFormFieldWidget(
                      label: 'Venture name',
                      hintText: 'Registered Venture Name',
                      prefixIcon: CupertinoIcons.person_fill,
                    ),
                    TextfiledPhone(
                      label: "Phone Number",
                      hintText: "Enter your number",
                      prefixIcon: Icons.phone_android,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
