import 'package:flutter/material.dart';
import '../../../core/themes/colors.dart';
import '../../widget/splashWidget/splash_widget.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.blackClr,
      body: ColoredBox(
        color: AppPalette.blackClr,
        child: SafeArea(
          child: SplashWidget()
          
        ),
      ),
    );
  }
}