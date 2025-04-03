import 'package:flutter/material.dart';
import 'package:user_panel/auth/presentation/widget/reset_widget/reset_password_widget.dart';
import 'package:user_panel/core/common/custom_appbar_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  final bool isWhat;
  final _formKey = GlobalKey<FormState>();
   ResetPasswordScreen({super.key, required this.isWhat});

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
             keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: BouncingScrollPhysics(),
            child: ResetPasswordWidget(screenHeight: screenHeight, screenWidth: screenWidth, isWhat: isWhat, formKey: _formKey)
           ),
          ),
        ),
       );
      });
  }
}