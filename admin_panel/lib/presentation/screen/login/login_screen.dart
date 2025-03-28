import 'package:admin/core/themes/colors.dart';
import 'package:admin/presentation/widget/login_widget/login_bottom_section.dart';
import 'package:admin/presentation/widget/login_widget/login_top_section.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/media_quary/media_quary_helper.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHight = MeidaQuaryHelper.height(context);
    double screenWidth = MeidaQuaryHelper.width(context);
    return Scaffold(
     resizeToAvoidBottomInset: true,
     body: ColoredBox(
      color: AppPalette.mainClr,
       child: SafeArea(
         child: GestureDetector(
           onTap: () => FocusScope.of(context).unfocus(),
           child: SingleChildScrollView(
             keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
             physics: BouncingScrollPhysics(),
             child: Column(
               children: [
                 LoginTopSection(screenHight: screenHight, screenWidth: screenWidth),
                 LoginBottomSection(screenHight: screenHight, screenWidth: screenWidth, formKey: _formKey)
               ],
             ),
           ),
         )
       ),
     ),
    );
  }
}