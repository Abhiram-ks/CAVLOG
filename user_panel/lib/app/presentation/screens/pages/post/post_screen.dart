import 'package:flutter/material.dart';
import '../../../../../core/common/custom_loadingscreen_widget.dart';
class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenHeight = constraints.maxHeight;
        double screenWidth = constraints.maxWidth;

        return SafeArea(
          child: Scaffold(
            body: LoadingScreen(screenHeight: screenHeight, screenWidth: screenWidth),
          ),
        );
      },
    );
  }
}
