import 'package:barber_pannel/core/common/common_loading_widget.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:(context, constraints){
        double screenHeight = constraints.maxHeight;
      double screenWidth = constraints.maxWidth;
        return Scaffold(
          body: LoadingScreen(screenHeight: screenHeight, screenWidth: screenWidth)
        );
      }
    );
  }
}