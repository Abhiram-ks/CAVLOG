import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieFilesCommon {
  LottieFilesCommon._();

  static Widget load({
    required String assetPath,
    required double width,
    required double height,
  }) {
    return Lottie.asset(
      assetPath,
      width: width,
      height: height,
    );
  }
}