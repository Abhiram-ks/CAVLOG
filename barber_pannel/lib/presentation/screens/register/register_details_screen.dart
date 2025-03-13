import 'package:barber_pannel/core/common/custom_appbar_common.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/common/google_singin_common.dart';
import '../../../core/routes/routes.dart';
import '../../../core/utils/constant/constant.dart';
import '../../../core/utils/media_quary/meida_quary_helper.dart';
import '../../widgets/register_widget/details_form_filed.dart';

class RegisterDetailsScreen extends StatelessWidget {
   RegisterDetailsScreen({super.key});
  
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
              physics: BouncingScrollPhysics(),
              child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.08,
                  ),child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Register here',
                        style: GoogleFonts.plusJakartaSans( fontSize: 28, fontWeight: FontWeight.bold),
                      ),ConstantWidgets.hight10(context),
                      Text('Please enter your data to complete your account registration process.'),
                      ConstantWidgets.hight20(context),
                      DetilsFormField( screenWidth: screenWidth, screenHight: screenHight, formKey: _formKey,), //form widget
                      ConstantWidgets.hight10(context),
                      GoogleSignInModule(
                          screenWidth: screenWidth,
                          screenHight: screenHight,
                          prefixText: "Already have an account?",
                          suffixText: " Login",
                          onTap: () => Navigator.pushNamed(context, AppRoutes.login)),
                    ],
                  )),
            ),
          ),
        ));
  }
}
