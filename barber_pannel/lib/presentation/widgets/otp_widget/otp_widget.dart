import 'package:barber_pannel/core/common/snackbar_common.dart';
import 'package:barber_pannel/core/themes/colors.dart';
import 'package:barber_pannel/presentation/provider/cubit/timerCubit/timer_cubit_cubit.dart';
import 'package:barber_pannel/presentation/widgets/otp_widget/navigation_to_admin.dart';
import 'package:barber_pannel/presentation/widgets/otp_widget/opttextformfiled.dart';
import 'package:barber_pannel/presentation/widgets/otp_widget/otp_snackbar_message_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/common/action_button_common.dart';
import '../../../core/utils/constant/constant.dart';
import '../../provider/bloc/RegisterSubmition/register_submition_bloc.dart';
import '../../provider/cubit/buttonProgress/button_progress_cubit.dart';

class OtpVerificationWidget extends StatefulWidget {
  final double screenHight;
  final double screenWidth;

  const OtpVerificationWidget(
      {super.key, required this.screenHight, required this.screenWidth});

  @override
  State<OtpVerificationWidget> createState() => _OtpVerificationWidgetState();
}

class _OtpVerificationWidgetState extends State<OtpVerificationWidget> {
  // final otpOneController = TextEditingController();
  // final otpTwoController = TextEditingController();
  // final otpThreeController = TextEditingController();
  // final otpForController = TextEditingController();
  // final otpFiveController = TextEditingController();
  // final otpSixController = TextEditingController();
  final List<TextEditingController> otpControllers = List.generate(6, (index) => TextEditingController());

  // String getUserOTP() {
  //   return otpOneController.text +
  //       otpTwoController.text +
  //       otpThreeController.text +
  //       otpForController.text +
  //       otpFiveController.text +
  //       otpSixController.text;
  // }
  void onOtpChanged() {
    if(otpControllers.every((controller) => controller.text.isNotEmpty)){
      sendOTP(context);
    }
  }

  String getUserOTP(){
     return otpControllers.map((controller) => controller.text).join();
  }

  void sendOTP(BuildContext context) async{
   final buttonCubit = context.read<ButtonProgressCubit>();
   final isVarification = context.read<RegisterSubmitionBloc>();

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
          children: List.generate(6, (index) => Opttextformfiled(screenWidth: widget.screenWidth, screenHight: widget.screenHight,controller: otpControllers[index], onChanged: (value) => onOtpChanged()))
        ),
        ConstantWidgets.hight30(context),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocConsumer<RegisterSubmitionBloc, RegisterSubmitionState>(
              listener: (context, state) {
              handleOtpState(context, state, true);
              if (state is OtpVarifyed) {
                final registerBloc = context.read<RegisterSubmitionBloc>();
                registerBloc.add(SubmitRegistration());
                navigateToAdminRequest(context);
              } else if (state is OtpIncorrect) {
                CustomeSnackBar.show(
                    context: context,
                    title: 'Invalid OTP',
                    description:"Oops! The OTP you entered is incorrect. Please check and try again. Error: ${state.error}",
                    iconColor: AppPalette.redClr,
                    icon: CupertinoIcons.number);
              }
            }, builder: (context, state) {
              return ActionButton(
                  screenWidth: widget.screenWidth,
                  onTap: () async {
                    final buttonCubit = context.read<ButtonProgressCubit>();
                    final isVarification = context.read<RegisterSubmitionBloc>();

                    buttonCubit.startLoading();
                    await Future.delayed(const Duration(seconds: 3));
                    final userOTP = getUserOTP();
                    isVarification.add(VerifyOTPEvent(inputOtp: userOTP));
                    buttonCubit.stopLoading();
                  },
                  label: 'Varify',
                  screenHight: widget.screenHight);
            }),
            ConstantWidgets.hight30(context),
            BlocBuilder<TimerCubitCubit, TimerCubitState>(
                builder: (context, state) {
              if (state is TimerCubitRunning) {
                return Text(
                  "Resend OTP in ${state.formattedTime}s",
                  style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold, color: Colors.red),
                );
              } else if (state is TimerCubitCompleted) {
                return GestureDetector(
                    onTap: () {
                      context.read<TimerCubitCubit>().startTimer();
                      context
                          .read<RegisterSubmitionBloc>()
                          .add(GenerateOTPEvent());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        Text(
                          "Did not receive the code? ",
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold),
                        ),
                        _buildOtpResendButton(context),
                      ],
                    ));
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
  return BlocListener<RegisterSubmitionBloc, RegisterSubmitionState>(
    listener: (context, state) {
      handleOtpState(context, state, false);
    },
    child: GestureDetector(
      onTap: () async {
        final timerCubit = context.read<TimerCubitCubit>();
        timerCubit.startTimer();
        context.read<RegisterSubmitionBloc>().add(GenerateOTPEvent());
      },
      child: Text(
        "Resend OTP",
        style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, color: AppPalette.blueClr),
      ),
    ),
  );
}
