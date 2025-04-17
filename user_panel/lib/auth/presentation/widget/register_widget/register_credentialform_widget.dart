import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_panel/auth/presentation/provider/bloc/register_bloc/register_bloc.dart';
import 'package:user_panel/auth/presentation/provider/cubit/button_progress_cubit/button_progress_cubit.dart';
import 'package:user_panel/auth/presentation/provider/cubit/checkbox_cubit/checkbox_cubit.dart';
import 'package:user_panel/auth/presentation/provider/cubit/timer_cubit/timer_cubit.dart';
import 'package:user_panel/auth/presentation/widget/otp_widget/otp_handlestates_widget.dart';
import 'package:user_panel/auth/presentation/widget/register_widget/terms_conditions_widget.dart';
import 'package:user_panel/core/common/custom_formfield_widget.dart';
import 'package:user_panel/core/routes/routes.dart';
import 'package:user_panel/core/utils/constant/constant.dart';
import 'package:user_panel/core/validation/input_validation.dart';
import '../../../../core/common/custom_actionbutton_widget.dart';
import '../../../../core/common/custom_snackbar_widget.dart';
import '../../../../core/themes/colors.dart';

class RegisterCredentialformWidget extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final GlobalKey<FormState> formKey;
  const RegisterCredentialformWidget(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.formKey});

  @override
  State<RegisterCredentialformWidget> createState() =>
      _RegisterCredentialformWidgetState();
}

class _RegisterCredentialformWidgetState
    extends State<RegisterCredentialformWidget> with FormFieldMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          children: [
            buildTextFormField(
                label: "Email",
                hintText: "Enter Email id",
                prefixIcon: CupertinoIcons.mail_solid,
                context: context,
                controller: emailController,
                validate: ValidatorHelper.validateEmailId),
            buildTextFormField(
                label: 'Create Password',
                hintText: 'Enter Password',
                prefixIcon: CupertinoIcons.padlock_solid,
                context: context,
                controller: passwordController,
                validate: ValidatorHelper.validatePassword,
                isPasswordField: true),
            buildTextFormField(
                label: 'Confirm Password',
                hintText: "Re-enter Password",
                prefixIcon: CupertinoIcons.padlock_solid,
                context: context,
                controller: confirmPasswordController,
                isPasswordField: true,
                validate: (val) => ValidatorHelper.validatePasswordMatch(
                    passwordController.text, val)),
            TermsAndConditionsWidget(),
            ConstantWidgets.hight30(context),
            BlocListener<RegisterBloc, RegisterState>(
              listener: (context, state) {
                 handleOtpState(context, state, true);
              },
              child: ButtonComponents.actionButton(
                  screenHeight: widget.screenHeight,
                  screenWidth: widget.screenWidth,
                  label: 'Send code',
                  onTap: () async{
                    if (!mounted) return;
                    final timerCubit = context.read<TimerCubit>();
                    final registerBloc = context.read<RegisterBloc>();
                    final buttonCubit = context.read<ButtonProgressCubit>();
                    final isChecked = context.read<CheckboxCubit>().state is CheckboxChecked;
                    final navigator = Navigator.of(context);
                    String? error = await ValidatorHelper.validateEmailWithFirebase(emailController.text);
                    log('Error due to email valid : ${error.toString()}');
                    
                    if (!mounted) return;
                    if (widget.formKey.currentState!.validate()) {
                      if (isChecked) {
                        if (error != null && error.isNotEmpty) {
                          if (!context.mounted) return;
                         CustomeSnackBar.show(context: context,title: "Oops, Error Occured",
                                description: '$error. Occured. Please try again!.', titleClr: AppPalette.redClr,);
                           return;
                        }
                         buttonCubit.startLoading();
                         log('message: user enter email: ${emailController.text.trim()} and password: ${passwordController.text.trim()}');
                         registerBloc.add(RegisterCredentialsData(email: emailController.text.trim(), password: passwordController.text.trim()));
                         registerBloc.add(GenerateOTPEvent());
                         await Future.delayed(const Duration(seconds: 2));
                         timerCubit.startTimer();
                         buttonCubit.stopLoading();
                        if (mounted) {
                           navigator.pushNamed(AppRoutes.otp);
                        }
                      }else{
                        if(!context.mounted) return;
                         CustomeSnackBar.show(
                         context: context,
                         title: 'Oops, you missed the checkbox',
                         description:'Agree with our terms and conditions before proceeding..',
                         titleClr: AppPalette.redClr,);
                       }
                     }else{
                   if(!context.mounted) return;
                    CustomeSnackBar.show(
                     context: context,
                     title: 'Submission Faild',
                     description:'Please fill in all the required fields before proceeding..',
                     titleClr: AppPalette.redClr,);
                     }
                   
                  }),
            )
          ],
        ));
  }
}
