import 'package:barber_pannel/core/routes/routes.dart';
import 'package:barber_pannel/core/utils/image/app_images.dart';
import 'package:barber_pannel/core/utils/media_quary/constant/constant.dart';
import 'package:barber_pannel/presentation/provider/bloc/splash/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {
       if (state is SplashAnimationCompleted) {
         Future.delayed(const Duration(microseconds: 500),(){
          if (context.mounted) {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          }
         });
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
                width: 140,
                height: 140,
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
                      colors: [Colors.white, Colors.black],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [animationValue, animationValue + 0.3],
                    ).createShader(bounds);
                  },
                  child: Text(
                    'C Λ V L O G',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
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
