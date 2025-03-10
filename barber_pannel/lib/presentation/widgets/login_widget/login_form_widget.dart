
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/common/action_button_common.dart';
import '../../../core/common/textfiled_common.dart';
import '../../../core/themes/colors.dart';
import '../../../core/utils/constant/constant.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.screenHight,
    required this.screenWidth,
  });

  final double screenHight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
                    TextFormFieldWidget(
      label: 'Email',
      hintText: 'abhiramks@gmail.com',
      prefixIcon: CupertinoIcons.mail_solid,
    ),
    TextFormFieldWidget(
      label: 'Password',
      hintText: '********',
      prefixIcon: CupertinoIcons.padlock_solid,
    ),
    GestureDetector(
      onTap: () {},
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(
          'Forgot Password?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ),
    ConstantWidgets.hight10(context),
    ActionButton(
      screenHight: screenHight,
      screenWidth: screenWidth,
      label: 'Login',
      onTap: () {},
    ),
    ConstantWidgets.hight10(context),
    const Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 0.9,
              color: AppPalette.hintClr,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "Or",
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 0.9,
              color: AppPalette.hintClr,
            ),
          ),
        ],
      ),
    ),
      ],
    );
  }
}
