import 'package:admin/core/themes/colors.dart';
import 'package:admin/core/utils/media_quary/constant/constant.dart';
import 'package:flutter/material.dart';

class CustomeSnackBar {
  static void show({
    required BuildContext context,
    required String title,
    required String description,
    required Color iconColor,
    required IconData icon,
  }){
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: TweenAnimationBuilder<double>(tween: Tween(begin: 0.0, end: 1.0), duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
         builder: (context, value, child) {
           return Transform.translate(
            offset: Offset(0, 20*(1 - value)),
            child: child,
            );
         },
         child: Stack(
           children: [
             Row(
              children: [
                Icon(icon, color: iconColor, size: 24),
                ConstantWidgets.width20(context),
                Expanded(child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                          title,
                          style: TextStyle(
                            color: AppPalette.blackClr,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: TextStyle(
                           color: const Color.fromARGB(255, 206, 208, 213),
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
              ],
             ),
             Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                    child: Icon(Icons.close, color: AppPalette.hintClr),
                  ),
                ),
           ],
         ),
         ),
         duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          elevation: 2,
          dismissDirection:  DismissDirection.down,
          backgroundColor: AppPalette.whiteClr,
           shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 20.0,
         ),
      ),
    );
  }
}