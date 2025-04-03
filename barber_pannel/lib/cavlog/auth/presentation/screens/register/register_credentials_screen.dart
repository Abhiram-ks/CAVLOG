
import 'package:barber_pannel/core/common/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/constant/constant.dart';
import '../../../../../core/utils/media_quary/media_quary_helper.dart';
import '../../widgets/register_widget/credential_form_filed.dart';

class RegisterCredentialsScreen extends StatelessWidget {
   RegisterCredentialsScreen({super.key});
  final _formKey = GlobalKey<FormState>();

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
          physics:const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.08,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Join Us Today',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                ConstantWidgets.hight10(context),
                Text( 'Create your account and unlock a world of possibilities.'),
                ConstantWidgets.hight20(context),
                CredentialsFormField(screenWidth: screenWidth, screenHight: screenHight,formKey: _formKey,),
              ],
            ),
          ),
        ), 
      )),
    );
  }
}
