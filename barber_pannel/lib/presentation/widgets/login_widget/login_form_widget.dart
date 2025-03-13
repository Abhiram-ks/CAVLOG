
import 'package:barber_pannel/core/validation/validation.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/common/action_button_common.dart';
import '../../../core/common/textfiled_common.dart';
import '../../../core/utils/constant/constant.dart';

class LoginForm extends StatelessWidget {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final emailIdController = TextEditingController();
    final passwordController = TextEditingController();

    LoginForm({
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
      hintText: 'Enter emial id',
      prefixIcon: CupertinoIcons.mail_solid,
      controller: emailIdController,
      validate: ValidatorHelper.validateEmailId,
    ),
    TextFormFieldWidget(
      label: 'Password',
      hintText: 'Enter Password',
      prefixIcon: CupertinoIcons.padlock_solid,
      isPasswordField: true,
      controller: passwordController,
      validate: ValidatorHelper.validateEmailId,
    
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
    ConstantWidgets.hight10(context),
    ActionButton(
      screenHight: screenHight,
      screenWidth: screenWidth,
      label: 'Login',
      onTap: () {},
    ),
    ConstantWidgets.hight10(context),
      ],
    );
  }
}
