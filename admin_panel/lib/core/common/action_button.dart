import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../presentation/provider/cubit/buttonProgress/button_progress_cubit.dart';
import '../themes/colors.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final double screenWidth;
  final double screenHight;

  const ActionButton({
    super.key,
    required this.screenWidth,
    required this.onTap,
    required this.label, required this.screenHight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHight * 0.06 ,
      width: screenWidth,
      child: Material(
        color: AppPalette.buttonClr,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          splashColor: Colors.white.withAlpha(77),
          child: Center(
            child: BlocBuilder<ButtonProgressCubit, ButtonProgressState>
            (builder: (context, state) {
              if (state is ButtonProgressLoading) {
                return SpinKitFadingFour(
                  color: AppPalette.whiteClr,
                  size: 23.0,
                ); 
              }return Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: AppPalette.whiteClr,
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
