import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utils/constant/constant.dart';

ClipRRect settingsWidget({required double screenHeight,required BuildContext context, required IconData icon,required  String title, required VoidCallback onTap}) {
  return ClipRRect(
          borderRadius: BorderRadius.circular(5),
           child: SizedBox(
            width:  double.infinity,
            height: screenHeight * 0.055,
             child: Material(
              color: AppPalette.scafoldClr,
               child: InkWell(
                hoverColor: AppPalette.blueClr.withValues(alpha: 0.40),
                splashColor: AppPalette.hintClr.withValues(alpha: 0.19 ),
                onTap:onTap,
                child: Ink(
                  color: AppPalette.scafoldClr,
                  child: Row(
                    children: [
                      ConstantWidgets.width20(context),
                      Icon(icon, color:AppPalette.blackClr),
                      ConstantWidgets.width40(context),
                      Expanded(child: Text(title,style: TextStyle(color:AppPalette.blackClr,fontSize: 17), maxLines: 1, overflow:TextOverflow.ellipsis,)),
                      
                    ],
                  ),
                ),
               ),
             ),
           ),
  );
}
