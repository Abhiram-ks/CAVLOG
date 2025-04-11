import 'package:barber_pannel/core/common/common_action_button.dart';
import 'package:barber_pannel/core/common/snackbar_helper.dart';
import 'package:barber_pannel/core/common/textfield_helper.dart';
import 'package:barber_pannel/core/validation/input_validations.dart';
import 'package:barber_pannel/cavlog/auth/presentation/widgets/reset_password_widget/handle_resetpassword_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/utils/constant/constant.dart';
import '../../../data/repositories/reset_password_repo.dart';
import '../../provider/bloc/ResetPasswordBloc/reset_password_bloc.dart';

class ResetPasswordWIdget extends StatefulWidget {
  const ResetPasswordWIdget({
    super.key,
    required this.screenWidth,
    required this.screenHight,
    required this.formKey,
    required this.isWhat,
  });

  final double screenWidth;
  final double screenHight;
  final bool isWhat;
  final GlobalKey<FormState> formKey;

  @override
  State<ResetPasswordWIdget> createState() => _ResetPasswordWIdgetState();
}

class _ResetPasswordWIdgetState extends State<ResetPasswordWIdget> {
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
            child: TextFormFieldWidget(
                label: 'Email',
                hintText: "Enter Email id",
                prefixIcon: CupertinoIcons.mail_solid,
                controller: emailController,
                validate: ValidatorHelper.validateEmailId),
          ),
          ConstantWidgets.hight30(context),
          BlocProvider(
            create: (context) => ResetPasswordBloc(ResetPasswordRepository()),
            child: BlocListener<ResetPasswordBloc, ResetPasswordState>(
              listener: (context, state) {
                handResetPasswordState(context, state);
              },  child: Builder(
                builder: (context) {
                  final resetPasswordBloc = context.read<ResetPasswordBloc>();
                  return ActionButton(
                    screenWidth: widget.screenWidth,
                    screenHight: widget.screenHight,
                    label: 'Send',
                    onTap: () async {
                      if (widget.formKey.currentState!.validate()) {
                        resetPasswordBloc.add(
                          ResetPasswordRequested(
                            email: emailController.text.trim(),
                          ),
                        );
                      } else {
                        CustomeSnackBar.show(
                          context: context,
                          title: 'Submission Failed',
                          description:
                              'Please fill in all the required fields before proceeding..',
                          titleClr: AppPalette.redClr,
                        );
                      }
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
