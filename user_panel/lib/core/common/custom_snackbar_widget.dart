import 'package:flutter/material.dart';
import '../themes/colors.dart';

class CustomeSnackBar {
  static void show({
    required BuildContext context,
    required String title,
    required String description,
    required Color titleClr,
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
                Expanded(child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title,style: TextStyle(
                            color:titleClr, fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: TextStyle(
                           color: AppPalette.greyClr,
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
          elevation: 3,
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