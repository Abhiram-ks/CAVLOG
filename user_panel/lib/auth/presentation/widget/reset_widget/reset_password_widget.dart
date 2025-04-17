import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_panel/auth/presentation/provider/bloc/reset_password/reset_password_bloc.dart';
import 'package:user_panel/auth/presentation/widget/reset_widget/reset_pass_statehandle.dart';
import 'package:user_panel/core/common/custom_formfield_widget.dart';
import '../../../../core/common/custom_actionbutton_widget.dart';
import '../../../../core/common/custom_snackbar_widget.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/utils/constant/constant.dart';
import '../../../../core/validation/input_validation.dart';

class ResetPasswordWidget extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final bool isWhat;
  final GlobalKey<FormState> formKey;
  const ResetPasswordWidget(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.isWhat,
      required this.formKey});

  @override
  State<ResetPasswordWidget> createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget>
    with FormFieldMixin {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.screenWidth * 0.08,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.isWhat ? 'Forgot password?' : 'Change password?',
            style: GoogleFonts.plusJakartaSans(
                fontSize: 28, fontWeight: FontWeight.bold),
          ),
          ConstantWidgets.hight10(context),
          Text(widget.isWhat
              ? "Enter your registered email address to receive a password reset link. Make sure to check your email for further instructions."
              : "Enter your registered email address to receive a password-changing link. Make sure to check your email for further instructions. After the process, your password will be updated."),
          ConstantWidgets.hight50(context),
          Form(
            key: widget.formKey,
            child: buildTextFormField(
                label: 'Email',
                hintText: 'Enter email id',
                prefixIcon: CupertinoIcons.mail_solid,
                context: context,
                controller: emailController,
                validate: ValidatorHelper.validateEmailId),
          ),
          ConstantWidgets.hight30(context),
          BlocListener<ResetPasswordBloc, ResetPasswordState>(
            listener: (context, state) {
              handResetPasswordState(context, state);
            },
            child: ButtonComponents.actionButton(
                screenHeight: widget.screenHeight,
                screenWidth: widget.screenWidth,
                label: 'Send',
                onTap: () async {
                  final resetPassword = context.read<ResetPasswordBloc>();
                  if(widget.formKey.currentState!.validate()){
                    resetPassword.add(ResetPasswordRequestEvent(email: emailController.text.trim()));
                  }else{
                     CustomeSnackBar.show(context: context, title: 'Submission Faild', description: 'Please fill in all the required fields before proceeding..', titleClr: AppPalette.redClr);
                  }
                }),
          ),
        ],
      ),
    );
  }
}
