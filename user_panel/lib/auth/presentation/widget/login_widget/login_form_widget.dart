import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_panel/core/common/custom_actionbutton_widget.dart';
import 'package:user_panel/core/common/custom_formfield_widget.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/constant/constant.dart';
import '../../../../core/validation/input_validation.dart';

class LoginFormWidget extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final GlobalKey<FormState> formKey;
  
  const LoginFormWidget({super.key, required this.screenHeight, required this.screenWidth, required this.formKey});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> with FormFieldMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key:  widget.formKey,
      child: Column(
        children: [
          buildTextFormField(label: 'Email', hintText: 'Enter email id', prefixIcon: CupertinoIcons.mail_solid, context: context, controller: emailController, validate: ValidatorHelper.validateEmailId),
          buildTextFormField(label: 'Password', hintText: 'Enter Password', prefixIcon:  CupertinoIcons.padlock_solid, context: context, controller: passwordController, validate: ValidatorHelper.loginValidation, isPasswordField: true),
          InkWell(
            onTap: () {
             Navigator.pushNamed(context, AppRoutes.resetPassword, arguments: true);
            },
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'Forgot Password?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ConstantWidgets.hight20(context),
          ButtonComponents.actionButton(screenHeight: widget.screenHeight, screenWidth: widget.screenWidth, label: 'Sign In', onTap: (){}),
        ],
      ));
  }
}