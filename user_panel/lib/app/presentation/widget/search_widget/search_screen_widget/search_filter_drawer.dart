import 'package:flutter/material.dart';
import 'package:user_panel/app/presentation/widget/search_widget/search_screen_widget/filter_function_iteams.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/utils/constant/constant.dart';
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      backgroundColor: AppPalette.scafoldClr,
      clipBehavior: Clip.antiAlias,
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      surfaceTintColor: AppPalette.whiteClr,
      width: screenWidth * 0.8,
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.14,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppPalette.blackClr,
              ),
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filter By',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Customize your search to find the perfect match—faster and smarter.',
                    style: TextStyle(color: AppPalette.whiteClr),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ),
          ConstantWidgets.hight10(context),
          serchFilterActionItems(screenWidth, context, screenHeight)
        ],
      ),
    );
  }
}
