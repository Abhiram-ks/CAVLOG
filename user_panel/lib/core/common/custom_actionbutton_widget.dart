import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/presentation/provider/cubit/button_progress_cubit/button_progress_cubit.dart';
import '../themes/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ButtonComponents{
  static Widget actionButton({
    required double screenHeight,
    required double screenWidth,
    required String label,
    required VoidCallback onTap,
    Color? buttonColor,
    Color? textColor,
  }){
    return SizedBox(
      height: screenHeight * 0.06 ,
      width: screenWidth,
      child: Material(
        color:buttonColor ?? AppPalette.buttonClr,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          splashColor: Colors.white.withAlpha(77),
          child: Center(
            child: BlocBuilder<ButtonProgressCubit, ButtonProgressState>
            (builder: (context, state) {
              if (state is ButtonProgressLoading) {
                return const SpinKitFadingFour(
                  color: AppPalette.whiteClr,
                  size: 23.0,
                ); 
              }return Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color:textColor ?? AppPalette.whiteClr,
                fontWeight: FontWeight.bold,
              ),
            );
            },
            )
          ),
        ),
      ),
    ); 
  }
}