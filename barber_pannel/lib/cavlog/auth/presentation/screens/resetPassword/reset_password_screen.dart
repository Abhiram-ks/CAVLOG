
import 'package:barber_pannel/core/common/custom_app_bar.dart';
import 'package:barber_pannel/core/utils/media_quary/media_quary_helper.dart';
import 'package:flutter/material.dart';

import '../../widgets/reset_password_widget/reset_password_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  final bool isWhat;
  ResetPasswordScreen({super.key, required this.isWhat});
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
            child: ResetPasswordWIdget(screenWidth: screenWidth,screenHight: screenHight,formKey: _formKey, isWhat: isWhat,),
          ),
        )
        ),
    );
  }
}
