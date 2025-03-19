import 'package:admin/core/common/action_button.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/common/textfield_helper.dart';
import '../../../core/utils/media_quary/constant/constant.dart';
import '../../../core/validation/input_validations.dart';

class LoginForm extends StatefulWidget {
  final double screenHight;
  final double screenWidth;
  final GlobalKey<FormState> formKey;
  
  const LoginForm({super.key, required this.screenHight, required this.screenWidth, required this.formKey});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormFieldWidget(
            label: 'Email',
            hintText: 'Enter emial id',
            prefixIcon: CupertinoIcons.mail_solid,
            controller: emailController,
            validate: ValidatorHelper.validateEmailId,
          ),
          TextFormFieldWidget(
            label: 'Password',
            hintText: 'Enter Password',
            prefixIcon: CupertinoIcons.padlock_solid,
            isPasswordField: true,
            controller: passwordController,
            validate: ValidatorHelper.validatePassword,
          ),
          ConstantWidgets.hight30(context),
          ActionButton(screenWidth: widget.screenWidth, onTap: (){}, label: 'Sign In', screenHight:widget.screenHight),
          ConstantWidgets.hight10(context),
        ],
      ),
    );
  }
}