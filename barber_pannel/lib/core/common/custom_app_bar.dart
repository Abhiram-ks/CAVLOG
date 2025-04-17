import 'package:flutter/material.dart';

import '../themes/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final VoidCallback? onPressed;
  final String? text;
  final Color? iconColor;

  const CustomAppBar({super.key, this.onPressed, this.iconColor, this.text})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppPalette.scafoldClr,
      iconTheme: IconThemeData(color: AppPalette.blackClr),
      elevation: 0,
      scrolledUnderElevation: 0,
      actions: text != null 
              ? [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: TextButton(
                    onPressed: onPressed, 
                    child: Text(text!,style: TextStyle(color:iconColor, fontWeight: FontWeight.bold),
                    ))
                )
              ] : []
    );
  }
}
