import 'dart:developer';

import 'package:barber_pannel/core/common/snackbar_helper.dart';
import 'package:barber_pannel/core/themes/colors.dart';
import 'package:barber_pannel/core/validation/input_validations.dart';
import 'package:barber_pannel/cavlog/auth/presentation/provider/bloc/RegisterSubmition/register_submition_bloc.dart';
import 'package:barber_pannel/cavlog/auth/presentation/provider/cubit/Checkbox/checkbox_cubit.dart';
import 'package:barber_pannel/cavlog/auth/presentation/provider/cubit/buttonProgress/button_progress_cubit.dart';
import 'package:barber_pannel/cavlog/auth/presentation/provider/cubit/timerCubit/timer_cubit_cubit.dart';
import 'package:barber_pannel/cavlog/auth/presentation/widgets/otp_widget/otp_snackbar_message_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common/action_button.dart';
import '../../../../../core/common/textfield_helper.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/utils/media_quary/constant/constant.dart';
import 'terms_and_conditions_widget.dart';

class CredentialsFormField extends StatefulWidget {
  const CredentialsFormField({
    super.key,
    required this.screenWidth,
    required this.formKey,
    required this.screenHight,
  });

  final double screenWidth;
  final double screenHight;
  final GlobalKey<FormState> formKey;

  @override
  State<CredentialsFormField> createState() => _CredentialsFormFieldState();
}

class _CredentialsFormFieldState extends State<CredentialsFormField> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormFieldWidget(label: "Email", hintText: "Enter Email id", prefixIcon: CupertinoIcons.mail_solid, controller: emailController, validate: ValidatorHelper.validateEmailId),
          TextFormFieldWidget(label: 'Create Password',hintText: 'Enter Password',isPasswordField: true, prefixIcon: CupertinoIcons.padlock_solid,
            controller: passwordController, validate: ValidatorHelper.validatePassword,
          ),
          TextFormFieldWidget(
            label: 'Confirm Password',
            hintText: 'Enter Password',
            prefixIcon: CupertinoIcons.padlock_solid,
            controller: confirmPasswordController,
            validate: (val) {
              return ValidatorHelper.validatePasswordMatch(
                  passwordController.text, val);
            },
            isPasswordField: true,
          ),
          ConstantWidgets.hight30(context),
          TermsAndConditionsWidget(),
          ConstantWidgets.hight10(context),
          BlocListener<RegisterSubmitionBloc, RegisterSubmitionState>(listener: (context, state) {
            handleOtpState(context, state, true);
          },
          child: ActionButton(screenWidth: widget.screenWidth,label: 'Send code', screenHight: widget.screenHight,
           onTap: () async{
              if (!mounted) return;
              final timerCubit = context.read<TimerCubitCubit>();
              final registerBloc = context.read<RegisterSubmitionBloc>();
              final buttonCubit = context.read<ButtonProgressCubit>();
              final isChecked = context.read<CheckboxCubit>().state is CheckboxChecked;
              final navigator = Navigator.of(context);
              String? error = await ValidatorHelper.validateEmailWithFirebase(emailController.text);
              log(error.toString());
              
              if (!mounted) return;
              if (widget.formKey.currentState!.validate()) {
                if (isChecked) {
                  if(error != null && error.isNotEmpty){
                     CustomeSnackBar.show(context: context,
                     title: "Email alredy exitst",
                     description: 'Email already exists, please try another email.', iconColor: AppPalette.redClr, icon:CupertinoIcons.mail_solid);
                     return;
                  }
                  buttonCubit.startLoading();
                  if (!mounted) return;
                  registerBloc.add(UpdateCredentials(email: emailController.text, isVerified: false, password: passwordController.text, isBloc: false));
                  registerBloc.add(GenerateOTPEvent());
                  timerCubit.startTimer();
                  await Future.delayed(const Duration(seconds: 3));
                   buttonCubit.stopLoading();
                  if (mounted) {
                    navigator.pushNamed(AppRoutes.otp);
                   }
                }else{
                  CustomeSnackBar.show(
                  context: context,
                  title: 'Oops, you missed the checkbox',
                  description:'Agree with our terms and conditions before proceeding..',
                  iconColor: AppPalette.redClr,icon: CupertinoIcons.checkmark_square);
                }
              }else{
                 CustomeSnackBar.show(
                 context: context,
                 title: 'Submission Faild',
                 description:'Please fill in all the required fields before proceeding..',
                 iconColor: AppPalette.redClr,
                icon: CupertinoIcons.clear_circled);
              }
           } ),
          )
        ],
      ),
    );
  }
}

