import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_panel/auth/presentation/widget/register_widget/register_detailsform_widget.dart';
import 'package:user_panel/core/common/custom_appbar_widget.dart';
import 'package:user_panel/core/common/custom_googlesignin_widget.dart';
import 'package:user_panel/core/utils/constant/constant.dart';

class RegisterDetailsScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  RegisterDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(
      builder: (context, constraints) {
       double screenHeight = constraints.maxHeight;
       double screenWidth = constraints.maxWidth; 
       
       return  Scaffold(
          appBar: const CustomAppBar(),
          body: SafeArea(
            child: GestureDetector(
               onTap: () => FocusScope.of(context).unfocus(),
              child:  SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                physics: BouncingScrollPhysics(),
                child: Padding(padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.08,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Register here', style: GoogleFonts.plusJakartaSans( fontSize: 28, fontWeight: FontWeight.bold)),
                      ConstantWidgets.hight10(context),
                      Text('Please enter your data to complete your account registration process.'),
                      ConstantWidgets.hight20(context),
                      RegisterDetailsFormWidget(screenHeight: screenHeight, screenWidth: screenWidth, formKey: _formKey),
                      ConstantWidgets.hight20(context),
                      CustomGooglesigninWidget.goToregister(prefixText:"Already have an account?", suffixText: " Login", screenWidth: screenWidth, screenHeight: screenHeight, onTap: ()=> Navigator.pop(context), context: context),
                      CustomGooglesigninWidget.googleSignInModule(screenWidth: screenWidth, screenHeight: screenHeight,context: context)
                    ],
                  ),
                  ),
              ),
            )),
        );
      });
  }
}