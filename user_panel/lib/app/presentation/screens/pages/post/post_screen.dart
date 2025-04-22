import 'package:flutter/material.dart';
import 'package:user_panel/core/common/custom_appbar_widget.dart';
import 'package:user_panel/core/themes/colors.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenHeight = constraints.maxHeight;
        double screenWidth = constraints.maxWidth;

        return ColoredBox(
          color: AppPalette.blackClr,
          child: SafeArea(
            child: Scaffold(
              appBar: CustomAppBar(isTitle: true, backgroundColor: AppPalette.blackClr,title: 'POSTS ˅',)
            
            ),
          ),
        );
      },
    );
  }
}
