import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_panel/auth/presentation/widget/register_widget/register_credentialform_widget.dart';
import 'package:user_panel/core/common/custom_appbar_widget.dart';
import '../../../../core/utils/constant/constant.dart';
class RegisterCredentialsScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
   RegisterCredentialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(
      builder: (context, constraints){
       double screenHeight = constraints.maxHeight;
       double screenWidth = constraints.maxWidth; 

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
                   Text('Join Us Today', style: GoogleFonts.plusJakartaSans( fontSize: 28, fontWeight: FontWeight.bold)),
                    ConstantWidgets.hight10(context),
                    Text('Create your account and unlock a world of possibilities.'),
                    ConstantWidgets.hight20(context),
                    RegisterCredentialformWidget(screenHeight: screenHeight, screenWidth: screenWidth, formKey: _formKey)
                  ],
                ),
                ),
            ),
          )),
       );
      });
  }
}