import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_panel/auth/presentation/provider/bloc/login_bloc/login_bloc.dart';
import 'package:user_panel/auth/presentation/widget/login_widget/login_statehandle_widget.dart';
import 'package:user_panel/core/common/custom_actionbutton_widget.dart';
import 'package:user_panel/core/common/custom_formfield_widget.dart';
import '../../../../core/common/custom_snackbar_widget.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/utils/constant/constant.dart';
import '../../../../core/validation/input_validation.dart';

class LoginFormWidget extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final GlobalKey<FormState> formKey;

  const LoginFormWidget(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.formKey});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> with FormFieldMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          children: [
            buildTextFormField(
                label: 'Email',
                hintText: 'Enter email id',
                prefixIcon: CupertinoIcons.mail_solid,
                context: context,
                controller: emailController,
                validate: ValidatorHelper.validateEmailId),
            buildTextFormField(
                label: 'Password',
                hintText: 'Enter Password',
                prefixIcon: CupertinoIcons.padlock_solid,
                context: context,
                controller: passwordController,
                validate: ValidatorHelper.loginValidation,
                isPasswordField: true),
            InkWell(
              onTap: () { Navigator.pushNamed(context, AppRoutes.resetPassword,
                    arguments: true);
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
            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                handleLoginState(context, state);
              },
              child: ButtonComponents.actionButton(
                  screenHeight: widget.screenHeight,
                  screenWidth: widget.screenWidth,
                  label: 'Sign In',
                  onTap: ()async {
                 if (widget.formKey.currentState!.validate()) {
                   FocusScope.of(context).unfocus();
                   log('messge: user enter email; ${emailController.text.trim()} and password: ${passwordController.text.trim()}');
                   context.read<LoginBloc>().add(LoginActionEvent(context, email:  emailController.text.trim(), password: passwordController.text.trim()));
                 } else {
                    CustomeSnackBar.show(context: context, title: 'Submission Faild',
                   description:'Please fill in all the required fields before  proceeding..',
                  titleClr: AppPalette.redClr,);
                 }
                  }),
            ),
          ],
        ));
  }
}
