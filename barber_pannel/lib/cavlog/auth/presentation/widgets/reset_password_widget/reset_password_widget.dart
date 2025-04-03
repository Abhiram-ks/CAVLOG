import 'package:barber_pannel/core/common/action_button.dart';
import 'package:barber_pannel/core/common/snackbar_helper.dart';
import 'package:barber_pannel/core/common/textfield_helper.dart';
import 'package:barber_pannel/core/validation/input_validations.dart';
import 'package:barber_pannel/cavlog/auth/presentation/provider/cubit/buttonProgress/button_progress_cubit.dart';
import 'package:barber_pannel/cavlog/auth/presentation/widgets/reset_password_widget/handle_resetpassword_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/utils/constant/constant.dart';
import '../../provider/bloc/ResetPasswordBloc/reset_password_bloc.dart';

class ResetPasswordWIdget extends StatefulWidget {
  const ResetPasswordWIdget({
    super.key,
    required this.screenWidth,
    required this.screenHight,
    required this.formKey,
    required this.description,
    required this.title
  });

  final double screenWidth;
  final double screenHight;
  final String title;
  final String description;
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
            widget.title,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 28, fontWeight: FontWeight.bold),
          ),
          ConstantWidgets.hight10(context),
          Text(
            widget.description),
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
          BlocListener<ResetPasswordBloc, ResetPasswordState>(
            listener: (context, state) {
             handResetPasswordState(context, state);
             },
            child: ActionButton(
                screenWidth: widget.screenWidth,
                onTap: ()async {
                 final buttonCubit = context.read<ButtonProgressCubit>();
                 final resetPasswordBloc = context.read<ResetPasswordBloc>();

                 if (widget.formKey.currentState!.validate()) {
                   buttonCubit.startLoading();
                   resetPasswordBloc.add(ResetPasswordRequested(email: emailController.text.trim()));
                   await Future.delayed(const Duration(seconds: 2));
                   buttonCubit.stopLoading(); 
                 }else{
                  CustomeSnackBar.show(context: context, title: 'Submission Faild', description: 'Please fill in all the required fields before proceeding..', iconColor: AppPalette.redClr, icon: CupertinoIcons.mail_solid);
                 }
                },
                label: 'Send',
                screenHight: widget.screenHight),
          )
        ],
      ),
    );
  }
}
