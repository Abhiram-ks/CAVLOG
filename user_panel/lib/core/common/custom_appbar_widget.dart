import 'package:flutter/material.dart';
import '../themes/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  
  @override
  final Size preferredSize;

  final String? title;
  final Color? backgroundColor;
  final bool? isTitle;
  final Color? titleColor;

  const CustomAppBar({
    super.key,
    this.title,
    this.backgroundColor,
    this.titleColor,
    this.isTitle = false
  })
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: isTitle == true
          ? Text(
              title!,
              style:  TextStyle(
                color:titleColor ?? Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
      backgroundColor: AppPalette.scafoldClr,
      iconTheme: IconThemeData(color: AppPalette.blackClr),
      elevation: 0,
      scrolledUnderElevation: 0,
    );
  }
}
