import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottiefilesCommon extends StatelessWidget {
  final String assetPath;
  final double widget;
  final double height;

  const LottiefilesCommon({super.key, required this.assetPath, required this.widget, required this.height});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      assetPath,
      width: widget,
      height: height,
    );
  }
}