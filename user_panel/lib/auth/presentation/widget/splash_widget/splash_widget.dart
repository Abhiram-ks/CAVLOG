import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_panel/auth/presentation/provider/bloc/splash_bloc/splash_bloc.dart';
import 'package:user_panel/core/routes/routes.dart';
import 'package:user_panel/core/utils/constant/constant.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/utils/image/app_images.dart' show AppImages;

class SplashWidget extends StatelessWidget {
  const SplashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is GoToLoginPage) {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        }else if (state is GoToHomePage){
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
            )
          ],
        );
      },
      );
  }
}