import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widget/banner_widget/image_pickand_upload.dart';
class BannerManagement extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  const BannerManagement(
      {super.key, required this.screenHeight, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ImagePickAndUploadWidget(screenWidth: screenWidth, screenHeight: screenHeight),
        ),
      );
    });
  }
}

