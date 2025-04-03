import 'package:barber_pannel/core/themes/colors.dart';
import 'package:barber_pannel/core/utils/media_quary/media_quary_helper.dart';
import 'package:barber_pannel/cavlog/auth/presentation/widgets/login_widget/login_top_widget.dart';
import 'package:flutter/material.dart';
import '../../widgets/login_widget/login_bottom_widget.dart';

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
        color: AppPalette.orengeClr,
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    LoginTopSection(screenHight: screenHight, screenWidth: screenWidth),
                    LotinBottomSection(screenWidth: screenWidth, screenHight: screenHight,formKey: _formKey,)
                  ],
                ),
              ),
            ),
          ),
      ),
      );
  }
}
