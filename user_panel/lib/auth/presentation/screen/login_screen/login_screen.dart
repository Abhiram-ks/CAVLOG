import 'package:flutter/material.dart';
import 'package:user_panel/auth/presentation/widget/login_widget/login_section_widget.dart';
import 'package:user_panel/core/themes/colors.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:(context, constraints){
       double screenHeight = constraints.maxHeight;
       double screenWidth = constraints.maxWidth;
        return Scaffold(
          body: ColoredBox(
            color: AppPalette.orengeClr,
            child: SafeArea(
              child: GestureDetector(
                onTap: () =>  FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    children: [
                      LoginComponents.loginTopSection(screenHeight, screenWidth),
                      LoginComponents.loginBottomSection(screenHeight, screenWidth, _formKey, context)
                    ],
                  ),
                ),
              ))
          ),
        );
      }
    );
  }
}