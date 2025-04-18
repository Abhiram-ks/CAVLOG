import 'package:flutter/material.dart';
import '../themes/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const CustomAppBar({super.key})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppPalette.scafoldClr,
      iconTheme: IconThemeData(color: AppPalette.blackClr),
      elevation: 0,
      scrolledUnderElevation: 0,
    );
  }
}
