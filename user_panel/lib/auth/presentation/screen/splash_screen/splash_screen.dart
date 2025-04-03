import 'package:flutter/material.dart';
import 'package:user_panel/auth/presentation/widget/splash_widget/splash_widget.dart';
import 'package:user_panel/core/themes/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints){
          return Scaffold(
           backgroundColor: AppPalette.blackClr,
           body: Center(
            child: SplashWidget()
           ),
          );
        }
      ),
    );
  }
}