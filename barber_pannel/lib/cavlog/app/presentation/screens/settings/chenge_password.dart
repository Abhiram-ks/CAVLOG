
import 'package:barber_pannel/core/common/custom_app_bar.dart';
import 'package:barber_pannel/core/utils/media_quary/meida_quary_helper.dart';
import 'package:flutter/material.dart';

import '../../../../auth/presentation/widgets/reset_password_widget/reset_password_widget.dart';

class ChengePassword extends StatelessWidget {
  ChengePassword({super.key});
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
            child: ResetPasswordWIdget(screenWidth: screenWidth,screenHight: screenHight,formKey: _formKey,title: 'Change password?' ,description:  "Enter your registered email address to receive a password-changing link. Make sure to check your email for further instructions. After the process, your password will be updated.",),
          ),
        )
        ),
    );
  }
}