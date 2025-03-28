import 'package:admin/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/routes/routes.dart';
import '../../../core/utils/images/app_images.dart';
import '../../../core/utils/media_quary/constant/constant.dart';
import '../../provider/bloc/fetchbarbers/fetch_barbers_bloc.dart';
import '../../provider/bloc/splash/splash_bloc.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashAnimationCompleted) {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        }else if(state is AdminGoToHome){
          context.read<FetchBarbersBloc>().add(FetchBarbersDataEvent());
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 170,
                height: 170,
                child: Image.asset(
                  AppImages.splashImage,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            ConstantWidgets.hight20(context),
            BlocBuilder<SplashBloc, SplashState>(
              builder: (context, state) {
                double animationValue = 0.0;

                if (state is SplashAnimating) {
                  animationValue = state.animationValue;
                }
                return ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: [AppPalette.whiteClr, AppPalette.blackClr],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [animationValue, animationValue + 0.3],
                    ).createShader(bounds);
                  },
                  child: Text(
                    'C Λ V L O G',
                    style: GoogleFonts.poppins(
                      color: AppPalette.whiteClr,
                      fontSize: 33,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                );
              },
            ),
            Text(
              'Executing Smarter, Managing Better',
              style: GoogleFonts.poppins(
                color: AppPalette.whiteClr,
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        );
      },
    );
  }
}
