import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_panel/auth/presentation/provider/bloc/register_bloc/register_bloc.dart';
import 'package:user_panel/auth/presentation/provider/cubit/timer_cubit/timer_cubit.dart';
import 'package:user_panel/auth/presentation/widget/otp_widget/otp_customform_widget.dart';
import 'package:user_panel/auth/presentation/widget/otp_widget/otp_handlestates_widget.dart';
import 'package:user_panel/core/common/custom_actionbutton_widget.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utils/constant/constant.dart';
import '../../provider/cubit/button_progress_cubit/button_progress_cubit.dart';
import 'otp_varifyhandlestate_widget.dart';

class OtpWidget extends StatefulWidget {
  final double screenHight;
  final double screenWidth;
  const OtpWidget(
      {super.key, required this.screenHight, required this.screenWidth});

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  final List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());

  void onOtpChanged() {
    if (otpControllers.every((controller) => controller.text.isNotEmpty)) {
      sendOTP(context);
    }
  }

  String getUserOTP() {
    return otpControllers.map((controller) => controller.text).join();
  }

  void sendOTP(BuildContext context) async {
    final buttonCubit = context.read<ButtonProgressCubit>();
    final isVarification = context.read<RegisterBloc>();
    buttonCubit.startLoading();
    await Future.delayed(const Duration(seconds: 3));
    final userOTP = getUserOTP();
    isVarification.add(VerifyOTPEvent(inputOtp: userOTP));
    buttonCubit.stopLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstantWidgets.hight50(context),
        ConstantWidgets.hight50(context),
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
                6,
                (index) => Opttextformfiled(
                    screenWidth: widget.screenWidth,
                    screenHight: widget.screenHight,
                    controller: otpControllers[index],
                    onChanged: (val) => onOtpChanged()))),
        ConstantWidgets.hight30(context),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocListener<RegisterBloc, RegisterState>(
              listener: (context, state) {
                handleOTPVarificationState(context, state);
              },
              child: ButtonComponents.actionButton(
                  screenHeight: widget.screenHight,
                  screenWidth: widget.screenWidth,
                  label: 'Verify',
                  onTap: () =>sendOTP(context))
            ),
            ConstantWidgets.hight30(context),
            BlocBuilder<TimerCubit, TimerState>(
              builder: (context, state) {
                if (state is TimerCubitRunning) {
                  return Text(
                    "Resend OTP in ${state.formattedTime}s",
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold, color: AppPalette.redClr),
                  );
                } else if (state is TimerCubitCompleted) {
                  return GestureDetector(
                    onTap: (){
                      context.read<TimerCubit>().startTimer();
                      context.read<RegisterBloc>().add(GenerateOTPEvent());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Did not receive the code? ",
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold),
                        ),
                        _buildOtpResendButton(context)
                      ],
                    )
                  );
                }
                return const SizedBox.shrink();
              })
          ],
        )
      ],
    );
  }
}

Widget _buildOtpResendButton(BuildContext context) {
  return BlocListener<RegisterBloc, RegisterState>(
    listener: (context, state) {
      handleOtpState(context, state, false);
    },
    child: GestureDetector(
      onTap: () async {
        final timerCubit = context.read<TimerCubit>();
        timerCubit.startTimer();
        context.read<RegisterBloc>().add(GenerateOTPEvent());
      },
      child: Text(
        "Resend OTP",
        style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.bold, color: AppPalette.blueClr),
      ),
    ),
  );
}
