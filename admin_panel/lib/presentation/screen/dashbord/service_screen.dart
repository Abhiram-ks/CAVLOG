import 'package:floating_tabbar/lib.dart';
import 'package:flutter/cupertino.dart';
import '../../widget/service_widget/upload_service_widget.dart';

class ServiceScreen extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const ServiceScreen(
      {super.key, required this.screenWidth, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
          ),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: BouncingScrollPhysics(),
              child: UploadServicesWidget(
                screenHight: screenHeight,
                screenWidth: screenWidth,
              ),
            ),
          ));
    });
  }
}